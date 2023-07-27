import 'package:clean_app/src/features/auth/data/services/local_auth_service.dart';
import 'package:clean_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'auth/ui/login_page.dart';
import 'home/ui/home_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<AuthService>((i) => LocalAuthService()),
        BlocBind.singleton((i) => AuthBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        ChildRoute('/login', child: (_, __) => const LoginPage()),
      ];
}
