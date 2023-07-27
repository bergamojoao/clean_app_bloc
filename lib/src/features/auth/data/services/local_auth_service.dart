import 'dart:convert';

import 'package:clean_app/src/features/auth/interactor/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../interactor/services/auth_service.dart';
import '../../interactor/states/auth_state.dart';

class LocalAuthService implements AuthService {
  @override
  Future<AuthState> login(String email, String password) async {
    if (email == 'joao02alex@gmail.com' && password == 'Joaoalex') {
      var user = UserEntity(
        id: 'myid',
        name: 'Joao Alex',
        email: 'joao02alex@gmail.com',
        token: 'uuidtokendasdsada',
      );
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('user', jsonEncode(user));

      return LoggedInAuthState(user);
    }
    return const LoggedOutAuthState();
  }

  @override
  Future<AuthState> logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    return const LoggedOutAuthState();
  }

  @override
  Future<AuthState> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user');

    if (user != null) {
      var userEntity = UserEntity.fromJson(jsonDecode(user));
      return LoggedInAuthState(userEntity);
    }

    return const LoggedOutAuthState();
  }
}
