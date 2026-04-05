import 'package:chatapp/features/chat/presentation/pages/chat_page.dart';
import 'package:chatapp/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:chatapp/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:chatapp/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    // Gọi fetch ngay khi vào trang
    context.read<ContactsBloc>().add(FetchContacts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) async {
          // Lấy bloc trước khi Navigator đẩy đi để tránh mất context
          final contactsBloc = context.read<ContactsBloc>();

          if (state is ConversationReady) {
            var res = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  conversationId: state.conversationId,
                  mate: state.contactName,
                ),
              ),
            );

            // Nếu quay lại từ chat page mà kết quả null, load lại danh sách
            if (res == null) {
              contactsBloc.add(FetchContacts());
            }
          } else if (state is ContactAdded) {
            // Thông báo khi thêm thành công (Tính năng mới mình thêm để UX tốt hơn)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Thêm liên hệ thành công!')),
            );
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          // CỰC KỲ QUAN TRỌNG:
          // Chỉ vẽ lại (rebuild) UI khi state liên quan đến hiển thị dữ liệu.
          // Điều này giúp ngăn chặn việc "nháy" màn hình khi state là ConversationReady.
          buildWhen: (previous, current) =>
          current is ContactsLoading ||
              current is ContactsLoaded ||
              current is ContactsError,
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContactsLoaded) {
              final contacts = state.contacts;

              if (contacts.isEmpty) {
                return const Center(child: Text('Chưa có liên hệ nào'));
              }

              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, idx) {
                  final contact = contacts[idx];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(contact.username),
                    subtitle: Text(contact.email),
                    onTap: () {
                      context.read<ContactsBloc>().add(
                        CheckOrCreateConversation(
                          contactId: contact.id,
                          contactName: contact.username,
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message));
            }

            // Trường hợp này sẽ không bao giờ nháy nữa vì buildWhen đã chặn ConversationReady
            return const Center(child: Text('Không tìm thấy danh sách liên hệ'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Thêm liên hệ mới'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Nhập vào email muốn tạo liên hệ',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huỷ bỏ'),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                // Sử dụng context của dialog để gửi event
                context.read<ContactsBloc>().add(AddContact(email));
                Navigator.pop(context);
              }
            },
            child: Text('Tạo', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}