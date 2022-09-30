import 'package:flutter/cupertino.dart';

class TodoListNavigator {
  TodoListNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
