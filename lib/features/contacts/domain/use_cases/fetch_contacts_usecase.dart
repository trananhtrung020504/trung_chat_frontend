import 'package:chatapp/features/contacts/domain/entities/contact_entity.dart';
import 'package:chatapp/features/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUsecase {
  final ContactsRepository repository;

  FetchContactsUsecase({required this.repository});


  Future<List<ContactEntity>> call() async {
    return repository.fetchContacts();
  }
}