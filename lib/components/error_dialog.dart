import 'package:flutter/material.dart';
import 'package:car_flutter/screens/auth_screen.dart';

class ErrorDialog extends StatelessWidget {
  // const ErrorDialog({super.key});

  final String message;
  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5.0,

      content: Text(message),
      actions: <Widget>[
        ElevatedButton(

          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          },

          child: Center(child: Text('OK',
          style: TextStyle(
            color: Colors.white
          ),)),

        )
      ],
    );
  }
}
