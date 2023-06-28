
import 'package:flutter/material.dart';
import 'package:send_remider_to_user/ui/add_todo/todo_list.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String todoListScreen = '/todoListScreen';
  static const String sign_up = '/sign_up';
  static const String otp = '/otp';

  static final routes = <String, WidgetBuilder>{
    todoListScreen: (BuildContext context) => TodoListScreen(),
   
  };
}
