import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:car_flutter/components/customTextField.dart';
import 'package:car_flutter/components/_rounded_button.dart';
import 'package:car_flutter/components/loading_dialog.dart';
import 'package:car_flutter/components/error_dialog.dart';
import 'package:car_flutter/screens/home_screen.dart';
import 'package:car_flutter/constants.dart';



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}



//
// class _LoginState extends State<Login> {
//   static final _auth=FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailcontroller=TextEditingController();
//   final TextEditingController _passwordcontroller=TextEditingController();
//
//
//   void _login() async{
//     showDialog(
//         context: context,
//         builder:(con){
//           return  LoadingDialog(
//             message :'Please Wait',
//           );
//         });
//     User? currentUser;
//
//     await _auth.signInWithEmailAndPassword(
//       email: _emailcontroller.text.trim(),
//       password: _passwordcontroller.text.trim(),
//     ).then((auth) {
//       currentUser = auth.user;
//     }).catchError((error) {
//       Navigator.pop(context);
//       showDialog(context: context, builder:(con){
//         return ErrorDialog(
//           message:error.message.toString(),
//         );
//       });
//     });
//     if(currentUser !=null){
//       Navigator.pop(context);
//       Route newRoute = MaterialPageRoute(builder: (context)=>HomeScreen());
//       Navigator.pushReplacement(context, newRoute);
//     }
//     else{
//       print("error");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//   // void _login() async {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return LoadingDialog(message: 'Please wait',
//   //       );
//   //     },
//   //   );
//   //   try {
//   //     final user = await _auth.signInWithEmailAndPassword(
//   //       email: _emailcontroller.text.trim(),
//   //       password: _passwordcontroller.text.trim(),
//   //     );
//   //
//   //     await Future.delayed(Duration(seconds: 3)); // Adjust the duration as needed
//   //
//   //     Navigator.pop(context);
//   //
//   //     if (user != null) {
//   //       Navigator.pushNamed(context, HomeScreen.id);
//   //     }
//   //   } catch (e) {
//   //     Navigator.pop(context);
//   //     final errorMessage = e.toString() ?? 'An error occurred'; // Use a fallback message if 'message' doesn't exist
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return ErrorDialog(message: errorMessage);
//   //       },
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _screenWidth=MediaQuery.of(context).size.width;
//     double _screenHeight=MediaQuery.of(context).size.height;
//
//
//     return SingleChildScrollView(
//       child: Container(
//         child:Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               alignment: Alignment.bottomCenter,
//               child:Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child:Image(
//                   image:AssetImage('images/logo.png'),
//                   height: 200.0,
//
//                 ),
//
//               )
//             ),
//             Form(
//               // key:_formKey ,
//               child:Column(
//                 children: <Widget>[
//                   CustomTextFieldWidget(controller: _emailcontroller,
//                       data: Icons.person
//
//                       , hintext: 'Email',
//                       isObscure: false,
//
//                   ),
//                   CustomTextFieldWidget(controller: _passwordcontroller,
//                       data: Icons.lock
//
//                       , hintext: 'Password',
//                       isObscure: true
//                   ),
//                 ],
//               )
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             RoundButton(colour: Colors.amberAccent, title: 'Log in', onpressed: (){
//               _emailcontroller.text.isNotEmpty &&
//                     _passwordcontroller.text.isNotEmpty? _login():
//                     showDialog(context: context, builder: (context){
//                       return ErrorDialog(message: 'Please write the required info for login!');
//                     });
//             })
//
//           ],
//         )
//       ),
//     );
//   }
// }



class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight =MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'images/logo.png',
                  height: 270.0,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldWidget(
                    isObscure: false,
                    data:Icons.person,
                    controller: _emailController,
                    hintext: 'Email',
                  ),
                  CustomTextFieldWidget(
                    isObscure: true,
                    data:Icons.lock,
                    controller: _passwordController,
                    hintext: 'Password',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width*0.5,
              child: RoundButton(colour: Colors.amberAccent, title: 'Log in', onpressed: (){
              _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty? _login():
                    showDialog(context: context, builder: (context){
                      return ErrorDialog(message: 'Please write the required info for login!');
                    });
            })
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void _login() async{
    showDialog(
        context: context,
        builder:(con){
          return  LoadingDialog(
            message :'Please Wait',
          );
        });


    User? currentUser;



    await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user;

    }).catchError((error) {
      Navigator.pop(context);
      showDialog(context: context, builder:(con){
        return ErrorDialog(
          message:error.message.toString(),
        );
      });
    });
    await Future.delayed(Duration(seconds: 3)); // Adjust the duration as needed

    Navigator.pop(context);
    if(currentUser !=null){
      Navigator.pop(context);
      // Route newRoute = MaterialPageRoute(builder: (context)=>HomeScreen());
      // Navigator.pushReplacement(context, newRoute);
      Navigator.pushNamed(context, HomeScreen.id);
    }
    else{
      print("error");
    }
  }
}