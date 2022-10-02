import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class CardFilter extends StatefulWidget {
  const CardFilter({Key? key}) : super(key: key);

  @override
  State<CardFilter> createState() => _CardFilterState();
}

class _CardFilterState extends State<CardFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(
          width: 1,
          color: Colors.purple.withOpacity(.5),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '10 TASKS',
            style: context.titleStyleHome.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Text(
            'HOJE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.purple.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 109, 255, 255),
            ),
            value: 0.4,
          ),
        ],
      ),
    );
  }
}
