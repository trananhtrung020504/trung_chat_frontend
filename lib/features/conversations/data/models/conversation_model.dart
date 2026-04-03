import 'package:chatapp/features/conversations/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity{


  ConversationModel({required id, required participantName, required lastMessage, required lastMessageTime}) : super(id: id,lastMessage: lastMessage,lastMessageTime: lastMessageTime,participantName: participantName);

  
  factory ConversationModel.fromJson(Map<String,dynamic> json){
    return ConversationModel(id: json['conversation_id'], participantName: json['participant_name'], lastMessage: json['last_message'], lastMessageTime: DateTime.parse(json['last_message_time']));
  }
}