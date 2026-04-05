import 'package:chatapp/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactUsecase {
  final ContactsRepository repository;

  AddContactUsecase({required this.repository});


  Future<void> call ({required String email}){
    return repository.addContact(email: email);
  }
}