import 'dart:convert';

import 'package:chatapp/core/app_config.dart';
import 'package:chatapp/features/contacts/data/models/contacts_model.dart';
import 'package:chatapp/features/contacts/domain/entities/contact_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContactsRemoteDataSource {
  final _storage = FlutterSecureStorage();

  Future<List<ContactsModel>> fetchContacts() async {
    String token = await _storage.read(key: 'token') ?? '';
    final res = await http.get(
      Uri.parse('${AppConfig.backend_endpoint}/api/contacts'),
      headers: {"Authorization": "Bearer $token"},
    );

    print('Res Fetch: ${res.body}');

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception('Thất bại khi lấy danh sách liên hệ');
    }
  }

  Future<void> addContact({required String email}) async {
    String token = await _storage.read(key: 'token') ?? '';
    print("Email: $email");
    final res = await http.post(
      Uri.parse('${AppConfig.backend_endpoint}/api/contacts'),
      body: jsonEncode({'contactEmail': email}),
      headers: {
        "Authorization":"Bearer $token",
        "Content-Type":'application/json'
      }
    );

    print('Vào đây: ${res.statusCode}');

    if(res.statusCode != 201){
      throw Exception('Gặp lỗi khi thêm liên hệ mới');
    }
  }
}
