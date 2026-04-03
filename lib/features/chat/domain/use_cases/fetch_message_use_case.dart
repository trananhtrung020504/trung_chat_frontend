import 'package:chatapp/features/chat/domain/entities/message_entity.dart';
import 'package:chatapp/features/chat/domain/repositories/message_repository.dart';

class FetchMessageUseCase {
  final MessageRepository messageRepository;

  FetchMessageUseCase({required this.messageRepository});

  Future<List<MessageEntity>> call (String conversationId) async {
    return messageRepository.fetchMessages(conversationId);
  }
}