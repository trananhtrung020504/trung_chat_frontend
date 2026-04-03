import 'package:chatapp/features/chat/data/datasource/message_remote_data_source.dart';
import 'package:chatapp/features/chat/data/repositories/message_repository.dart';
import 'package:chatapp/features/chat/domain/use_cases/fetch_message_use_case.dart';
import 'package:chatapp/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chatapp/features/chat/presentation/pages/chat_page.dart';
import 'package:chatapp/core/theme.dart';
import 'package:chatapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chatapp/features/auth/data/repositores/auth_repository.dart';
import 'package:chatapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:chatapp/features/auth/domain/usecases/register_use_case.dart';
import 'package:chatapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatapp/features/auth/presentation/pages/login_page.dart';
import 'package:chatapp/features/auth/presentation/pages/register_page.dart';
import 'package:chatapp/features/conversations/data/datasource/conversations_remote_data_source.dart';
import 'package:chatapp/features/conversations/data/repositories/conversations_repository.dart';
import 'package:chatapp/features/conversations/domain/use_cases/fetch_conversations_use_case.dart';
import 'package:chatapp/features/conversations/presentation/bloc/conversations_bloc.dart';
import 'package:chatapp/features/conversations/presentation/pages/conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authRepository = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationRepository = ConversationsRepositoryImpl(remoteDataSource: ConversationsRemoteDataSource());
  final messageRepository = MessageRepositoryImpl(messageRemoteDataSource: MessageRemoteDataSource());
  runApp(MyApp(authRepository: authRepository, conversationRepository: conversationRepository,messageRepository: messageRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationRepository;
  final MessageRepositoryImpl messageRepository;
  const MyApp({super.key, required this.authRepository, required this.conversationRepository, required this.messageRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(
          loginUseCase: LoginUseCase(repository: authRepository),
          registerUseCase: RegisterUseCase(repository: authRepository)
        )),
        BlocProvider(create: (_) => ConversationsBloc(fetchConversationsUseCase: FetchConversationsUseCase(repository: conversationRepository))),

        BlocProvider(create: (_) => ChatBloc(fetchMessageUseCase: FetchMessageUseCase(messageRepository: messageRepository)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home: LoginPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register' : (_) => RegisterPage(),
          '/conversationsPage': (_) => ConversationsPage()

        },
      ),
    );
  }
}

