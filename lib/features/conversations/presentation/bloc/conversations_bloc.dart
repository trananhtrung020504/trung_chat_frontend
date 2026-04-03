import 'package:chatapp/features/conversations/domain/use_cases/fetch_conversations_use_case.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_event.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent,ConversationsState>{
  final FetchConversationsUseCase fetchConversationsUseCase;

  ConversationsBloc({required this.fetchConversationsUseCase}) : super(ConversationsInitial()){
    on<FetchConversations>(_onFetchConversations);
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
}