import 'package:clean_app/src/features/auth/interactor/events/auth__events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../auth/interactor/blocs/auth_bloc.dart';
import '../../auth/interactor/states/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AuthBloc>();
    final state = bloc.state;

    late Widget child;

    if (state is LoggedInAuthState) {
      child = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ola, ${state.user.name}'),
          ElevatedButton(
            onPressed: () {
              final event = LogoutAuthEvent();
              bloc.add(event);
            },
            child: const Text('Logout'),
          )
        ],
      );
    } else {
      child = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nao logado!'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: child,
      ),
    );
  }
}
