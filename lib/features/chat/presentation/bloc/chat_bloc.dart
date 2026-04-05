import 'package:chatapp/core/socket_service.dart';
import 'package:chatapp/features/chat/domain/entities/message_entity.dart';
import 'package:chatapp/features/chat/domain/use_cases/fetch_message_use_case.dart';
import 'package:chatapp/features/chat/presentation/bloc/chat_event.dart';
import 'package:chatapp/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService _socketService = SocketService();

  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();




  ChatBloc({required this.fetchMessageUseCase}) : super(ChatLoadingState()){
    on<LoadMessageEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
  }

  Future<void> _onLoadMessages(LoadMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try{
      final messages = await fetchMessageUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));

      _socketService.socket.off('newMessage');
      print('Load messsage');
      _socketService.socket.emit('joinConversation',event.conversationId);
      _socketService.socket.on('newMessage', (data) {
        print('Step1 - receive: $data');
        add(ReceiveMessageEvent(data));
      });
    }catch(e){
      emit(ChatErrorState('Thất bại trong việc lấy danh sách tin nhắn'));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    final userId = await _storage.read(key: 'userId') ?? '';
    print('userId: $userId');

    final newMessage = {
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId
    };

    _socketService.socket.emit('sendMessage',newMessage);
  }

  Future<void> _onReceiveMessage(ReceiveMessageEvent event, Emitter<ChatState> emit) async {
    print("Step2 - receive event called");
    print(event.message);
    final message = MessageEntity(id: event.message['id'], conversationId: event.message['conversation_id'], senderId: event.message['sender_id'], content: event.message['content'], createdAt: event.message['created_at']);

    _messages.add(message);

    emit(ChatLoadedState(List.from(_messages)));
  }


}