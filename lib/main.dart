import 'package:chatapp/chat_page.dart';
import 'package:chatapp/core/theme.dart';
import 'package:chatapp/login_page.dart';
import 'package:chatapp/message_page.dart';
import 'package:chatapp/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: LoginPage(),
    );
  }
}

