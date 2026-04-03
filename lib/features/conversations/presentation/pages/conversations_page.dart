import 'package:chatapp/core/theme.dart';
import 'package:chatapp/features/chat/presentation/pages/chat_page.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_bloc.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {


  @override
  void initState() {
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversations());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin nhắn', style: theme.textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Gần đây', style: theme.textTheme.bodySmall),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact(context: context, theme: theme, name: "A"),
                _buildRecentContact(context: context, theme: theme, name: "B"),
                _buildRecentContact(context: context, theme: theme, name: "C"),
                _buildRecentContact(context: context, theme: theme, name: "D"),
                _buildRecentContact(context: context, theme: theme, name: "E"),
                _buildRecentContact(context: context, theme: theme, name: "A"),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: DefaultColors.messageListPage,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)
              )
            ),
            child: BlocBuilder<ConversationsBloc,ConversationsState>(builder: (context,state){
              if (state is ConversationsLoading){
                return Center(child: CircularProgressIndicator(),);
              } else if (state is ConversationsLoaded){
                return ListView.builder(
                    itemCount: state.conversations.length,
                    itemBuilder: (context,idx){
                  final conversation = state.conversations[idx];
                  return GestureDetector(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(conversationId: conversation.id, mate: conversation.participantName)));
                  }, child: _buildMessageTile(conversation.participantName, conversation.lastMessage, conversation.lastMessageTime.toString()));
                });
              }else if (state is ConversationsError){
                return Center(child: Text(state.message));
              }
              return Center(child: Text("Không tìm thấy phòng hội thoại nào"),);

            },)
          ))

        ],
      ),
    );
  }
}



Widget _buildRecentContact({
  required BuildContext context,
  required ThemeData theme,
  required String name,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        ),
        SizedBox(height: 5),
        Text(name, style: theme.textTheme.bodyMedium),
      ],
    ),
  );
}

Widget _buildMessageTile(String name, String message,String time){
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
    ),
    title: Text(name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    subtitle: Text(
      message,
      style: TextStyle(
        color: Colors.grey,
        overflow: TextOverflow.ellipsis
      ),
    ),
    trailing: Text(
      time,
      style: TextStyle(color: Colors.grey),
    ),
  );
}
