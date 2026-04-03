import 'package:chatapp/features/chat/data/datasource/message_remote_data_source.dart';
import 'package:chatapp/features/chat/domain/entities/message_entity.dart';
import 'package:chatapp/features/chat/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});


  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    // TODO: implement fetchMessages
    return messageRemoteDataSource.fetchMessages(conversationId);
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

}