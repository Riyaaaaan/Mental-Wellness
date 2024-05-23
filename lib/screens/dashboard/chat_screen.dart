import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mental_wellness/api/api_const.dart';
import 'package:mental_wellness/services/chat/components/message_tile.dart';
import 'package:mental_wellness/utils/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Content> history = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  bool _loading = false;
  static const _apiKey = ApiKey.apiKEY;
  final String instructions = instruction;

  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _ttsPlaying = false;

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
    );
    _chat = await _model.startChat();
    if (_chat == null) {
      _showError('Failed to start chat session');
    }
  }

  Future _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    setState(() {
      _ttsPlaying = true;
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        _ttsPlaying = false;
      });
    });
  }

  void _stopTTS() async {
    await flutterTts.stop();
    setState(() {
      _ttsPlaying = false;
    });
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
            _textController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Assistant'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            icon: Icon(_ttsPlaying ? Icons.stop : Icons.volume_up),
            onPressed: _ttsPlaying ? _stopTTS : () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 90),
            itemCount: history.reversed.length,
            controller: _scrollController,
            reverse: true,
            itemBuilder: (context, index) {
              var content = history.reversed.toList()[index];
              var text = content.parts
                  .whereType<TextPart>()
                  .map<String>((e) => e.text)
                  .join('');
              return MessageTile(
                sendByMe: content.role == 'user',
                message: text,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 15,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade200))),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                        cursorColor: Colors.blue,
                        controller: _textController,
                        autofocus: true,
                        focusNode: _textFieldFocus,
                        decoration: InputDecoration(
                            hintText: 'message',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _listen,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        history.add(
                            Content('user', [TextPart(_textController.text)]));
                      });
                      _sendChatMessage(_textController.text, history.length);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                                spreadRadius: 3,
                                color: Colors.black.withOpacity(0.05))
                          ]),
                      child: _loading
                          ? const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message, int historyIndex) async {
    setState(() {
      _loading = true;
      _textController.clear();
      _textFieldFocus.unfocus();
      _scrollDown();
    });

    List<Part> parts = [];

    try {
      if (_chat == null) {
        _showError('Chat session is not initialized');
        return;
      }

      var response = _chat.sendMessageStream(
        Content.text("$instructions\n$message"),
      );
      await for (var item in response) {
        var text = item.text;
        if (text == null) {
          _showError('No response from API.');
          return;
        } else {
          setState(() {
            _loading = false;
            parts.add(TextPart(text));
            if ((history.length - 1) == historyIndex) {
              history.removeAt(historyIndex);
            }
            history.insert(historyIndex, Content('model', parts));
          });

          _speak(text);
        }
      }
    } catch (e, t) {
      print(e);
      print(t);
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
