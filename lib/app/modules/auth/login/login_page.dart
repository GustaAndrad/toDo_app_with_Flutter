// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../home/widgets/home_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      everCallBack: (notifier, listenerNotifier) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      sucessCallBack: (notifier, listenerInstance) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeBackground(),
          LayoutBuilder(
            builder: (context, constraints) {
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
                        const SizedBox(height: 60),
                        const TodoListLogo(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TodoListField(
                                  label: 'E-mail',
                                  controller: _emailEC,
                                  focusNode: _emailFocus,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Email obrigatorio'),
                                    Validatorless.email('Email invalido')
                                  ]),
                                ),
                                const SizedBox(height: 20),
                                TodoListField(
                                  label: 'Password',
                                  obscureText: true,
                                  controller: _passwordEC,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Senha obrigatorio'),
                                    Validatorless.min(6,
                                        'Senha deve conter pelo menos 6 caracteres')
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (_emailEC.text.isNotEmpty) {
                                          context
                                              .read<LoginController>()
                                              .forgotPassword(_emailEC.text);
                                        } else {
                                          _emailFocus.requestFocus();
                                          Messages.of(context).showError(
                                              'Digite um email para recuperar a senha');
                                        }
                                      },
                                      child: const Text(
                                        'Esqueceu sua senha?',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 234, 173, 250),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final formValid =
                                            _formKey.currentState?.validate() ??
                                                false;
                                        if (formValid) {
                                          final email = _emailEC.text;
                                          final password = _passwordEC.text;
                                          context
                                              .read<LoginController>()
                                              .login(email, password);
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
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
                              color: Color.fromARGB(255, 8, 0, 56),
                              border: Border(
                                top: BorderSide(
                                  width: 5,
                                  color: Colors.purpleAccent.withOpacity(0.1),
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  SignInButton(
                                    Buttons.Google,
                                    text: 'Continue com o Google',
                                    padding: const EdgeInsets.all(5),
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none),
                                    onPressed: () {
                                      context
                                          .read<LoginController>()
                                          .googleLogin();
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Nao tem conta ? ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/register');
                                        },
                                        child: const Text(
                                          'Cadastre-se',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 229, 128, 255),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
