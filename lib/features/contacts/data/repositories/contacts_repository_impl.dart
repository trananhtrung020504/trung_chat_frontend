import 'package:chatapp/features/contacts/data/datasource/contacts_remote_data_source.dart';
import 'package:chatapp/features/contacts/domain/entities/contact_entity.dart';
import 'package:chatapp/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository{
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl({required this.contactsRemoteDataSource});

  @override
  Future<void> addContact({required String email}) {
    // TODO: implement addContact
    return contactsRemoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() {
    // TODO: implement fetchContacts
    return contactsRemoteDataSource.fetchContacts();
  }

}