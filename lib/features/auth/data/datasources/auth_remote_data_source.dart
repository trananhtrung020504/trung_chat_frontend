import 'package:chatapp/core/app_config.dart';
import 'package:chatapp/features/auth/data/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class AuthRemoteDataSource {
  // 192.168.1.7 là ip của wifi laptop
  final String baseUrl = '${AppConfig.backend_endpoint}/api/auth';

  Future<UserModel> login ({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print('res: ${response.body}');


    return UserModel.fromJson(jsonDecode(response.body)['user']);
  }

  Future<UserModel> register ({required String username, required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({'username': username, 'email': email,'password':password}),
      headers: {
        "Content-Type": "application/json"
      }
    );

    print('res: ${response.body}');
    return UserModel.fromJson(jsonDecode(response.body)['user']);
  }
}