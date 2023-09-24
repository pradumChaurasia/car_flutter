import 'package:car_flutter/components/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:car_flutter/components/customTextField.dart';
import 'package:car_flutter/components/_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_flutter/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_flutter/constants.dart';
// import 'package:car_flutter/components/error_dialog.dart';
import 'package:car_flutter/components/error_dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneConfirmController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
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
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFieldWidget(
                    data: Icons.person,
                    controller: _nameController,
                    hintext: 'Name',
                    isObscure: false,
                  ),
                  CustomTextFieldWidget(
                    data: Icons.person,
                    controller: _phoneConfirmController,
                    hintext: 'Phone',
                    isObscure: false,
                  ),
                  CustomTextFieldWidget(
                    data: Icons.email,
                    controller: _emailController,
                    hintext: 'Email',
                    isObscure: false,
                  ),
                  CustomTextFieldWidget(
                    data: Icons.camera_alt_outlined,
                    controller: _imageController,
                    hintext: 'Image Url',
                    isObscure: false,
                  ),
                  CustomTextFieldWidget(
                    data: Icons.lock,
                    controller: _passwordController,
                    hintext: 'Password',
                    isObscure: true,
                  ),
                  CustomTextFieldWidget(
                    data: Icons.lock,
                    controller: _passwordConfirmController,
                    hintext: 'Confirm Password',
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RoundButton(
                          colour: Colors.amberAccent,
                          title: 'Register',
                          onpressed: () {
                            _register();
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveUserData() {
    Map<String, dynamic> userData = {
      'userName': _nameController.text.trim(),
      'uId': userId,
      'userNumber': _phoneConfirmController.text.trim(),
      'imgPro': _imageController.text.trim(),
      'time': DateTime.now(),
    };
    FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
  }

  void _register() async {
    User? currentUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
      userId = currentUser!.uid;
      userEmail = currentUser!.email!;
      getUserName = _nameController.text.trim();
      saveUserData();
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
  }
}

// class Register extends StatefulWidget {
//   static const id='register_screen';
//   const Register({super.key});
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailcontroller = TextEditingController();
//   final TextEditingController _passwordcontroller = TextEditingController();
//   final TextEditingController _namecontroller = TextEditingController();
//   final TextEditingController _passwordConfirmcontroller =
//       TextEditingController();
//   final TextEditingController _phoneConfirmcontroller = TextEditingController();
//   final TextEditingController _imagecontroller = TextEditingController();
//
//   final _auth=FirebaseAuth.instance;
//
//   void _register() async{
//     // User currentUser;
//       try{
//         final newUser=await _auth.createUserWithEmailAndPassword(email: _emailcontroller.text.trim(),
//             password: _passwordcontroller.text.trim());
//         saveUserData();
//         if(newUser!=null){
//           Navigator.pushNamed(context, HomeScreen.id);
//         }
//       }
//       catch(e){
//         Navigator.pop(context);
//         showDialog(context: context, builder: (con){
//           return ErrorDialog(message: e.toString());
//         });
//       }
//   }
//   void saveUserData()async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       String userId = user.uid;
//
//       Map<String, dynamic> userData = {
//         'userName': _namecontroller.text.trim(),
//         'uid': userId,
//         'userNumber': _phoneConfirmcontroller.text.trim(),
//         'imgPro': _imagecontroller.text.trim(),
//         'time': DateTime.now(),
//       };
//       try {
//         await FirebaseFirestore.instance.collection('users').doc(userId).set(
//             userData);
//       } catch (e) {
//         // Handle any potential Firestore errors here
//         print("Error saving user data: $e");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: EdgeInsets.all(15.0),
//                   child: Image(
//                     image: AssetImage('images/logo.png'),
//                     height: 200.0,
//                   ),
//                 )),
//             Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     CustomTextFieldWidget(
//                       controller: _namecontroller,
//                       data: Icons.person,
//                       hintext: 'Name',
//                       isObscure: false,
//                     ),
//                     CustomTextFieldWidget(
//                       controller: _phoneConfirmcontroller,
//                       data: Icons.phone,
//                       hintext: 'Phone Number',
//                       isObscure: false,
//                     ),
//                     CustomTextFieldWidget(
//                       controller: _emailcontroller,
//                       data: Icons.person,
//                       hintext: 'Email',
//                       isObscure: false,
//                     ),
//                     CustomTextFieldWidget(
//                       controller: _imagecontroller,
//                       data: Icons.camera_alt_outlined,
//                       hintext: 'Image URL',
//                       isObscure: false,
//                     ),
//                     CustomTextFieldWidget(
//                         controller: _passwordcontroller,
//                         data: Icons.lock,
//                         hintext: 'Password',
//                         isObscure: true),
//                     CustomTextFieldWidget(
//                         controller: _passwordConfirmcontroller,
//                         data: Icons.lock,
//                         hintext: 'Confirm Password',
//                         isObscure: true),
//                   ],
//                 )),
//             SizedBox(
//               height: 10.0,
//             ),
//             RoundButton(
//                 colour: Colors.amberAccent, title: 'Register', onpressed: () {
//                     _register();
//             })
//           ],
//         ),
//       ),
//     );
//   }
//
// }
