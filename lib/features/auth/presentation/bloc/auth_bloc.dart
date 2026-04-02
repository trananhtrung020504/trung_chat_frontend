import 'package:chatapp/features/auth/domain/usecases/login_use_case.dart';
import 'package:chatapp/features/auth/domain/usecases/register_use_case.dart';
import 'package:chatapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:chatapp/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();
  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()){
   on<RegisterEvent>(_onRegister);
   on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try{
      final user = await registerUseCase.call(event.username, event.email, event.password);
      emit(AuthSuccess(message: 'Đăng kí thành công'));
    }catch(e){
      print('error: $e');
      emit(AuthFailure(error: "Đăng kí thất bại: $e"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try{
      final user = await loginUseCase.call(event.email, event.password);
      await _storage.write(key: 'token', value: user.token);
      print('token: ${user.token}');

      emit(AuthSuccess(message: 'Đăng nhập thành công'));
    }catch(e){
      print('Error: $e');
      emit(AuthFailure(error: 'Đăng nhập thất bại: $e'));
    }
  }


}