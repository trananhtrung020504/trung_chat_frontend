import 'package:chatapp/core/theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showInputValues(){

  }

  @override
  void dispose() {
    // TODO: implement dispose
     _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextInput("Email",Icons.person,_emailController),
            SizedBox(height: 20,),
            _buildTextInput("Mật khẩu",Icons.person,_passwordController,isPassword: true),
            SizedBox(height: 20,),
            _buildLoginPrompt(),
            SizedBox(height: 20,),
            _buildRegisterPrompt()

          ],
        ),),
      ),
    );
  }

  Widget _buildTextInput(String hint,IconData icon, TextEditingController controller, {bool isPassword = false}){
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

  Widget _buildRegisterPrompt(){
    return Center(child: GestureDetector(
      onTap: (){

      },
      child: RichText(
          text: TextSpan(
              text: 'Bạn chưa có tài khoản?  ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                    text: 'Đăng kí ngay',
                    style: TextStyle(color: Colors.blue)
                )
              ]
          )),
    ),);
  }

  Widget _buildLoginPrompt(){
    return ElevatedButton(onPressed: _showInputValues, style: ElevatedButton.styleFrom(
        backgroundColor: DefaultColors.buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        padding: EdgeInsets.symmetric(vertical: 15)
    ),
      child: Text('Đăng nhập',style: TextStyle(color: Colors.white),),

    );
  }
}
