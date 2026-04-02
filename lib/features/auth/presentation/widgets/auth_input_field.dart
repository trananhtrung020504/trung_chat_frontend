
import 'package:chatapp/core/theme.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;

  const AuthInputField({super.key, required this.hint, required this.controller, required this.icon, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: DefaultColors.sentMessageInput,
          borderRadius: BorderRadius.circular(25)
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon,color: Colors.grey,),
          SizedBox(width: 10,),
          Expanded(child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none
            ),
            style: TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
