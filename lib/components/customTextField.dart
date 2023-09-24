//

import 'package:flutter/material.dart';
import 'package:car_flutter/constants.dart';
import 'dart:io' show Platform;

class CustomTextFieldWidget extends StatelessWidget {
  // const CustomTextFieldWidget({super.key});

  final TextEditingController controller;
  final IconData data;
  final String hintext;
  bool isObscure = true;
  // final Color colour;

  CustomTextFieldWidget(
      {required this.controller,
      required this.data,
      required this.hintext,
      required this.isObscure});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Container(
        width: Platform.isAndroid || Platform.isIOS
            ? _screenWidth
            : _screenWidth * 0.5,
        decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,
          obscureText: isObscure,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber.shade50, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              prefixIcon: Icon(
                data,
                color: Colors.amberAccent,
              ),
              focusColor: Theme.of(context).primaryColor,
              hintText: hintext),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'dart:io' show Platform;
// class CustomTextField extends StatelessWidget {
//
//   final TextEditingController? controller;
//   final IconData? data;
//   final String? hintText;
//   bool isObsecure = true;
//
//   CustomTextField({this.controller,this.data,this.hintText,required this.isObsecure});
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width,
//         _screenHeight = MediaQuery
//             .of(context)
//             .size
//             .height;
//
//     return Container(
//       width:Platform.isAndroid || Platform.isIOS ? _screenWidth :  _screenWidth * 0.5,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       padding: EdgeInsets.all(8.0),
//       margin: EdgeInsets.all(10.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText:isObsecure,
//         cursorColor:Theme.of(context).primaryColor,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           prefixIcon: Icon(
//             data,
//             color: Colors.cyan,
//           ),
//           focusColor: Theme.of(context).primaryColor,
//           hintText: hintText,
//         ),
//       ),
//     );
//   }
// }
