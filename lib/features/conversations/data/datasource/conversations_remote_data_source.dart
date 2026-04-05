import 'dart:convert';

import 'package:chatapp/core/app_config.dart';
import 'package:chatapp/features/conversations/data/models/conversation_model.dart';
import 'package:chatapp/features/conversations/domain/entities/conversation_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class ConversationsRemoteDataSource {
  final String baseUrl = 'http://192.168.1.7:5000/api';
  final _storage = FlutterSecureStorage();


  Future<List<ConversationEntity>> fetchConversations() async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        "Authorization": "Bearer $token"
      }
    );

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi lấy đoạn hội thoại");
    }
  }

  Future<String> checkOrCreateConversation({required String contactId}) async {
    final String token = await _storage.read(key: 'token') ?? '';

    final res = await http.post(Uri.parse('${AppConfig.backend_endpoint}/api/conversations/check-or-create'),body: jsonEncode(
        {
          "contactId":contactId
        }),headers: {
      "Content-Type":'application/json',
      "Authorization":"Bearer $token"
    });

    if(res.statusCode == 200){
      var data = jsonDecode(res.body);
      return data['conversationId'];
    }else {
      throw Exception('Lỗi khi kiểm tra hoặc tạo mới đoạn hội thoại');
    }
  }

}