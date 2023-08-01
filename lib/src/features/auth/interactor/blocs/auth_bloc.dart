import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_events.dart';
import '../services/auth_service.dart';
import '../states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;

  AuthBloc(this.service) : super(const LoggedOutAuthState()) {
    on<LoginAuthEvent>(_loginAuthEvent);
    on<LogoutAuthEvent>(_logoutAuthEvent);
    on<CheckAuthEvent>(_checkAuthEvent);
  }

  void _loginAuthEvent(LoginAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.login(
      event.email,
      event.password,
    );
    emit(newState);
  }

  void _logoutAuthEvent(LogoutAuthEvent event, emit) async {
    emit(const LoadingAuthState());
    final newState = await service.logout();
    emit(newState);
  }

  void _checkAuthEvent(CheckAuthEvent event, emit) async {
    // emit(const LoadingAuthState());
    final newState = await service.getUser();
    emit(newState);
  }
}
