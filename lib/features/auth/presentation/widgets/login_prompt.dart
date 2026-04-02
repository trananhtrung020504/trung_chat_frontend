import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  const LoginPrompt({super.key, required this.subTitle, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: 'Bạn chưa có tài khoản?  ',
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: 'Đăng kí ngay',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
