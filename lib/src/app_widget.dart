import 'dart:async';

import 'package:clean_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/auth/interactor/events/auth_events.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<AuthBloc>().stream.listen(
      (state) {
        if (state is LoggedInAuthState) {
          Modular.to.navigate('/');
        } else if (state is LoggedOutAuthState) {
          Modular.to.navigate('/login');
        }
      },
    );
    context.read<AuthBloc>().add(CheckAuthEvent());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login');

    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
    );
  }
}
