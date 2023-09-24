import 'package:flutter/material.dart';
import 'loading.dart';
class LoadingDialog extends StatelessWidget {
  // const LoadingDialog({super.key});

  final String message;
  LoadingDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5.0,
      backgroundColor: Colors.white,

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          CircularLoading(),
          SizedBox(
            height: 10.0,

          ),
          Text('Authenticating Please Wait...',
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}
