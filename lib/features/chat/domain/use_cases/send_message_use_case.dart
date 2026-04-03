import 'package:chatapp/features/chat/domain/entities/message_entity.dart';
import 'package:chatapp/features/chat/domain/repositories/message_repository.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase({required this.messageRepository});

  Future<void> sendMessage(MessageEntity message) async {
    return await messageRepository.sendMessage(message);
  }
}