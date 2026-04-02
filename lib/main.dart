import 'package:chatapp/chat_page.dart';
import 'package:chatapp/core/theme.dart';
import 'package:chatapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:chatapp/features/auth/data/repositores/auth_repository.dart';
import 'package:chatapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:chatapp/features/auth/domain/usecases/register_use_case.dart';
import 'package:chatapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatapp/features/auth/presentation/pages/login_page.dart';
import 'package:chatapp/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authRepository = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  runApp(MyApp(authRepository: authRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(
          loginUseCase: LoginUseCase(repository: authRepository),
          registerUseCase: RegisterUseCase(repository: authRepository)
        ))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        home: RegisterPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register' : (_) => RegisterPage(),
          '/chatPage': (_) => ChatPage()

        },
      ),
    );
  }
}

