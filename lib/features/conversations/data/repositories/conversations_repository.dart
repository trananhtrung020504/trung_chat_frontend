import 'package:chatapp/features/conversations/data/datasource/conversations_remote_data_source.dart';
import 'package:chatapp/features/conversations/domain/entities/conversation_entity.dart';
import 'package:chatapp/features/conversations/domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsRemoteDataSource remoteDataSource;

  ConversationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await remoteDataSource.fetchConversations();
  }

  @override
  Future<String> checkOrCreateConversation({required String contactId}) {
    // TODO: implement checkOrCreateConversation
    return remoteDataSource.checkOrCreateConversation(contactId: contactId);
  }

}