import 'package:http/http.dart' as http;

import '../../api/api_const.dart';
import 'chat_req.dart';
import 'chat_response.dart';

class ChatService {
  static final Uri chatUri =
      Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.apiKEY}',
  };

  Future<String?> request(String prompt) async {
    try {
      // Initial instruction message to set the tone for the chatbot's behavior
      final instructionMessage = Message(
          role: "system",
          content: "You are someone intimate and comfortable to talk with, "
              "who helps solve problems and gives necessary advice. "
              "You should listen attentively, offer supportive and constructive feedback, "
              "and provide advice in a friendly and understanding manner. "
              "Remember to keep the conversation respectful and positive, "
              "encouraging a safe and welcoming environment for sharing concerns.");

      ChatRequest request = ChatRequest(
          model: "gpt-3.5-turbo",
          maxTokens: 200,
          messages: [
            instructionMessage,
            Message(role: "user", content: prompt)
          ]);
      if (prompt.isEmpty) {
        return null;
      }
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: request.toJson(),
      );
      ChatResponse chatResponse = ChatResponse.fromResponse(response);
      print(chatResponse.choices?[0].message?.content);
      return chatResponse.choices?[0].message?.content;
    } catch (e) {
      print("error $e");
    }
    return null;
  }
}
