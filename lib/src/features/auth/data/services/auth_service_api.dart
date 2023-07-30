import 'dart:developer';

import 'package:clean_app/src/core/utils/api_services.dart';
import 'package:clean_app/src/features/auth/interactor/entities/user_entity.dart';
import 'package:clean_app/src/features/auth/interactor/states/signup_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../interactor/dtos/signup_dto.dart';
import '../../interactor/services/auth_service.dart';
import '../../interactor/states/auth_state.dart';

class AuthServiceApi implements AuthService {
  final api = ApiService.api;

  @override
  Future<AuthState> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<AuthState> login(String email, String password) async {
    try {
      var response = await api.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token']);
        return LoggedInAuthState(UserEntity(token: response.data['token']));
      }
    } catch (e) {
      log(e.toString());
    }

    return const LoggedOutAuthState();
  }

  @override
  Future<AuthState> logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    return const LoggedOutAuthState();
  }

  @override
  Future<SignupState> signup(SignupDTO signupDTO) async {
    try {
      var response = await api.post(
        '/users',
        data: signupDTO.toJson(),
      );

      if (response.statusCode == 201) {
        return SubmitedSignupState(signupDTO);
      }
    } catch (e) {
      log(e.toString());
    }
    return const FailedSignupState('Erro ao se cadastrar.');
  }
}
