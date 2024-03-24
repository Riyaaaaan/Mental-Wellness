import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mental_wellness/services/openai/chat_services.dart';
import 'package:mental_wellness/utils/config.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _ttsEnabled = true; // TTS enabled state variable
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _speech.initialize();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void _speak(String text) async {
    if (_ttsEnabled) {
      // Check if TTS is enabled before speaking
      await _flutterTts.speak(text);
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  _messageController.text = val.recognizedWords;
                  if (val.finalResult) {
                    _isListening = false;
                  }
                }));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _sendMessage(String messageText) async {
    setState(() {
      messages.add({"text": messageText, "isUser": true});
    });
    _messageController.clear();

    // Scroll to bottom to show the latest message
    _scrollToBottom();

    final response = await ChatService().request(messageText);
    if (response != null && response.isNotEmpty) {
      setState(() {
        messages.add({"text": response, "isUser": false});
      });
      _speak(response); // Read the assistant's response aloud.
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Chat with Assistant"),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            icon: Icon(_ttsEnabled ? Icons.volume_up : Icons.volume_off),
            onPressed: () async {
              if (_ttsEnabled) {
                // If TTS is currently enabled, stop any ongoing speech
                await _flutterTts.stop();
              }
              setState(() {
                _ttsEnabled = !_ttsEnabled;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(Config.widthSize! * 0.03),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["isUser"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Config.heightSize! * 0.01),
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.widthSize! * 0.05,
                        vertical: Config.heightSize! * 0.02),
                    decoration: BoxDecoration(
                      color:
                          message["isUser"] ? Colors.deepPurple : Colors.white,
                      borderRadius:
                          BorderRadius.circular(Config.widthSize! * 0.1),
                    ),
                    child: Text(
                      message["text"],
                      style: TextStyle(
                        color: message["isUser"]
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Config.widthSize! * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: "Message",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(Config.widthSize! * 0.03)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_off,
                      color: Colors.deepPurple),
                  onPressed: _listen,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    final messageText = _messageController.text;
                    if (messageText.isNotEmpty) {
                      _sendMessage(messageText);
                    }
                  },
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
