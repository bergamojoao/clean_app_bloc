import 'package:clean_app/src/features/auth/interactor/blocs/auth_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/events/auth__events.dart';
import 'package:clean_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AuthBloc>();
    final state = bloc.state;

    final isLoading = state is LoadingAuthState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                email = value;
              },
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              ElevatedButton(
                onPressed: () {
                  final event = LoginAuthEvent(
                    email: email,
                    password: password,
                  );
                  bloc.add(event);
                },
                child: const Text('Login'),
              )
          ],
        ),
      ),
    );
  }
}
