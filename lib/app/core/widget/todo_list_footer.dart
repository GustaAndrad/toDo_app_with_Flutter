import 'package:flutter/material.dart';

class TodoListFooter extends StatelessWidget {
  const TodoListFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            height: 30,
          ),
        ),
        Text(
          'Your best App Todo list',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
