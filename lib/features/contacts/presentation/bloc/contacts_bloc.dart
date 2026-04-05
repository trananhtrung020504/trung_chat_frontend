import 'package:chatapp/features/contacts/domain/entities/contact_entity.dart';
import 'package:chatapp/features/contacts/domain/use_cases/add_contact_usecase.dart';
import 'package:chatapp/features/contacts/domain/use_cases/fetch_contacts_usecase.dart';
import 'package:chatapp/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chatapp/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:chatapp/features/conversations/domain/use_cases/check_or_create_conversation_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUsecase fetchContactsUsecase;
  final AddContactUsecase addContactUsecase;
  final CheckOrCreateConversationUsecase checkOrCreateConversationUsecase;

  // Biến tạm để giữ danh sách liên hệ cũ, tránh bị mất UI khi chuyển đổi state
  List<ContactEntity> _contacts = [];

  ContactsBloc({
    required this.addContactUsecase,
    required this.fetchContactsUsecase,
    required this.checkOrCreateConversationUsecase,
  }) : super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
    on<AddContact>(_onAddContact);
    on<CheckOrCreateConversation>(_onCheckOrCreateConversation);
  }

  Future<void> _onFetchContacts(FetchContacts event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
      _contacts = await fetchContactsUsecase();
      emit(ContactsLoaded(_contacts));
    } catch (e) {
      emit(ContactsError('Lỗi khi lấy danh sách liên hệ: $e'));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<ContactsState> emit) async {
    // Khi thêm mới, ta có thể hiện loading vì UI Dialog đã đóng
    emit(ContactsLoading());
    try {
      await addContactUsecase(email: event.email);
      emit(ContactAdded());
      add(FetchContacts()); // Tự động load lại danh sách
    } catch (e) {
      emit(ContactsError('Lỗi khi thêm liên hệ: $e'));
    }
  }

  Future<void> _onCheckOrCreateConversation(
      CheckOrCreateConversation event, Emitter<ContactsState> emit) async {
    try {
      // ĐỪNG emit(ContactsLoading) ở đây nếu bạn muốn giữ List cũ hiện trên màn hình
      final conversationId = await checkOrCreateConversationUsecase(contactId: event.contactId);

      // Bắn state Ready để Listener bắt được và chuyển trang
      emit(ConversationReady(
        conversationId: conversationId,
        contactName: event.contactName,
      ));

      // Quan trọng: Sau khi Ready, trả lại state Loaded ngay lập tức
      // để BlocBuilder không bị rơi vào trường hợp mặc định (nháy chữ "Không tìm thấy")
      emit(ContactsLoaded(_contacts));
    } catch (e) {
      emit(ContactsError('Lỗi khi bắt đầu cuộc hội thoại'));
    }
  }
}