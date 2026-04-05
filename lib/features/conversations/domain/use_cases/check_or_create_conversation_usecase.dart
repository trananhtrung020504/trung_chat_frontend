import 'package:chatapp/features/conversations/domain/repositories/conversations_repository.dart';

class CheckOrCreateConversationUsecase {
  final ConversationsRepository repository;

  CheckOrCreateConversationUsecase({required this.repository});


  Future<String> call({required String contactId}) async {
    return repository.checkOrCreateConversation(contactId: contactId);
  }
}