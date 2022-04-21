// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DefaultMessage extends StatelessWidget {
  final titulo;
  final mensaje;
  final popped;
  final VoidCallback onPopped;
  DefaultMessage({
    this.titulo,
    this.mensaje,
    this.popped = true,
    required this.onPopped,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$titulo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('$mensaje'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            popped ? Navigator.of(context).pop() : print('$popped');
            onPopped.call();
          },
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
