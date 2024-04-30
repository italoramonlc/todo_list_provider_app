import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);


  factory Messages.of(BuildContext context){
    return Messages._(context);
  }

  void showError(String message) => _showMessege(message, Colors.red);

  void showInfo(String message) => _showMessege(message, context.primaryColor);

  void _showMessege(String message,Color color){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
        backgroundColor: color,
      ),
    );
  }

}