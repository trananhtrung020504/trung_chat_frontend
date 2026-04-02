import 'package:chatapp/core/theme.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),

            ),
            SizedBox(width: 10,),
            Text('Anh Trung',style: theme.textTheme.titleMedium,)
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],

      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              _buildReceivedMessage(context,"Đã gửi",theme),
              _buildSentMessage(context, "Đã nhận", theme),
            ],
          )),
          _buildMessageInput()
        ],
      )
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message,ThemeData theme){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          right: 30,top: 5, bottom: 5
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(message,style: theme.textTheme.bodyMedium,),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message,ThemeData theme){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            left: 30,top: 5, bottom: 5
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: DefaultColors.senderMessage,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Text(message,style: theme.textTheme.bodyMedium,),
      ),
    );
  }

  Widget _buildMessageInput(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: DefaultColors.sentMessageInput,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(Icons.camera_alt,color: Colors.grey,),
            onTap: (){},
      
          ),
          SizedBox(width: 10,),
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: "Tin nhắn",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none
            ),
            style: TextStyle(color: Colors.white),
          )),
          SizedBox(width: 10,),
          GestureDetector(
            child: Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onTap: (){},
          )
        ],
      ),
    );
  }
}
