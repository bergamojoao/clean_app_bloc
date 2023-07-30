import 'package:clean_app/src/features/auth/interactor/blocs/signup_bloc.dart';
import 'package:clean_app/src/features/auth/interactor/dtos/signup_dto.dart';
import 'package:clean_app/src/features/auth/interactor/events/signup_events.dart';
import 'package:clean_app/src/features/auth/interactor/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var signupDTO = SignupDTO(
    name: '',
    email: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SignupBloc>();
    final state = bloc.state;

    final isLoading = state is LoadingAuthState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              initialValue: signupDTO.name,
              onChanged: (value) {
                signupDTO.name = value;
              },
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                signupDTO.email = value;
              },
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              onChanged: (value) {
                signupDTO.password = value;
              },
              enabled: !isLoading,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
            ),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              ElevatedButton(
                onPressed: () {
                  final event = SubmitSignupEvent(signupDTO: signupDTO);
                  bloc.add(event);
                },
                child: const Text('Cadastrar-se'),
              )
          ],
        ),
      ),
    );
  }
}
