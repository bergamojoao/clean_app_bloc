import '../entities/user_entity.dart';

sealed class AuthState {
  const AuthState();
}

class LoggedInAuthState implements AuthState {
  final UserEntity user;

  const LoggedInAuthState(this.user);
}

class LoggedOutAuthState implements AuthState {
  const LoggedOutAuthState();
}

class LoadingAuthState implements AuthState {
  const LoadingAuthState();
}
