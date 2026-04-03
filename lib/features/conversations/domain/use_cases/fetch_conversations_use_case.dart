import 'package:chatapp/features/conversations/domain/entities/conversation_entity.dart';
import 'package:chatapp/features/conversations/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;


  FetchConversationsUseCase({required this.repository});

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversations();
  }
}