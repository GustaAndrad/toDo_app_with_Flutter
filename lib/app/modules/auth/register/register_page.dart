import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
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
                  child: Column(
                    children: [
                      TodoListField(label: 'Email'),
                      SizedBox(
                        height: 20,
                      ),
                      TodoListField(
                        label: 'Senha',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TodoListField(
                        label: 'Confirme a senha',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
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
