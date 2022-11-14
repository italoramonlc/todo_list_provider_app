import 'package:flutter/material.dart';

import '../ui/todo_list_icon.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool obscureText;
  TodoListField({Key? key, required this.label, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red),
          ),
          isDense: true,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              TodoListIcon.eye,
              size: 15,
            ),
          )),
      obscureText: obscureText,
    );
  }
}
