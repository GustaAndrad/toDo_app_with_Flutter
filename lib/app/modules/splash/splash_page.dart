import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://static.wikia.nocookie.net/afca1f5b-149d-44e7-bd53-9dfeef2ca674/scale-to-width/755'),
                  fit: BoxFit.cover),
            ),
          ),
          Center(
            child: TodoListLogo(),
          ),
        ],
      ),
    );
  }
}
