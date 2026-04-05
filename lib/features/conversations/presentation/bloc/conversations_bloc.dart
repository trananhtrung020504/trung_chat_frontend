import 'package:chatapp/core/socket_service.dart';
import 'package:chatapp/features/conversations/domain/use_cases/fetch_conversations_use_case.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent,ConversationsState>{
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();

  ConversationsBloc({required this.fetchConversationsUseCase}) : super(ConversationsInitial()){
    on<FetchConversations>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
    try{
      _socketService.socket.on('conversationUpdated',_onConversationUpdated);
    }catch(e){
      print('Có lôi khi khởi tạo người lắng nghe socket');
    }
  }

  Future<void> _onFetchConversations(FetchConversations event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());

    try{
      final conversations = await fetchConversationsUseCase.call();
      emit(ConversationsLoaded(conversations));
    }catch(e){
      emit(ConversationsError('Lấy đoạn hội thoại thất bại'));
    }
  }

  void _onConversationUpdated(data){
    add(FetchConversations());
  }
}