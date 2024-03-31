import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const TodoListLogo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(),
                          const SizedBox(height: 20),
                          TextFormField(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('Esqueceu sua senha?'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text('Login'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF0F3F7),
                      border: Border(
                        top: BorderSide(
                          width: 2,
                          color: Colors.grey.withAlpha(50),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                          text: 'Continue com o Google',
                          padding: const EdgeInsets.all(5),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não tem conta?'),
                            TextButton(
                                onPressed: () {},
                                child: const Text('Cadastre-se'))
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}