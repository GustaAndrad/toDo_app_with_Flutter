import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();

  final _passwordEC = TextEditingController();

  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      sucessCallBack: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },
      errorCallBack: (notifier, listenerNotifier) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To do List',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://static.wikia.nocookie.net/afca1f5b-149d-44e7-bd53-9dfeef2ca674/scale-to-width/755'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          ListView(
            children: [
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.width * .5,
                child: FittedBox(
                  child: TodoListLogo(),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TodoListField(
                          label: 'Email',
                          controller: _emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Email obrigatorio'),
                            Validatorless.email('Email invalido!')
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                      TodoListField(
                        label: 'Senha',
                        controller: _passwordEC,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatoria'),
                          Validatorless.min(
                              6, 'Senha deve ter no minimo 6 caracteres')
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TodoListField(
                        label: 'Confirme a senha',
                        controller: _confirmPasswordEC,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Obrigatorio confirmar senha'),
                          Validators.compare(_passwordEC, 'Senhas diferentes')
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              final email = _emailEC.text;
                              final password = _passwordEC.text;
                              context
                                  .read<RegisterController>()
                                  .registerUser(email, password);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
