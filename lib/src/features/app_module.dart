import 'package:clean_app/src/features/auth/data/services/auth_service_impl.dart';
import 'package:clean_app/src/features/auth/data/services/google_auth_service_impl.dart';
import 'package:clean_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/blocs/signup_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:clean_app/src/features/auth/interactor/services/google_auth_service.dart';
import 'package:clean_app/src/features/auth/ui/signup_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth/ui/login_page.dart';
import 'home/ui/home_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<AuthService>(AuthServiceImpl.new);
    i.add<GoogleAuthService>(GoogleAuthServiceImpl.new);
    i.addSingleton(AuthBloc.new);
    i.addSingleton(SignupBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/login', child: (_) => const LoginPage());
    r.child('/signup', child: (_) => const SignupPage());
  }
}
