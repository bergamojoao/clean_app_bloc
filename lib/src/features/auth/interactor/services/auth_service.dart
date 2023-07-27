import '../states/auth_state.dart';

abstract interface class AuthService {
  Future<AuthState> login(String email, String password);

  Future<AuthState> logout();

  Future<AuthState> getUser();
}
