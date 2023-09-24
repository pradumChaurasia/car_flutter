import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_flutter/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_flutter/screens/home_screen.dart';
import 'dart:io' show Platform;

class SplashScreen extends StatefulWidget {
  static const id='splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // startTimer(){
  //   Timer(Duration(seconds: 3), () async{
  //     await Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.redAccent
            ],
            begin: FractionalOffset(0.0,0.0),
            end: FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
          )
        ),
        child:Center(
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image:AssetImage('images/logo.png'),


                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('Find or Deal your Car',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Platform.isAndroid || Platform.isIOS? 20.0:60.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                  fontFamily: 'Lobster-Regular'
                ),
                ),
                Container(
                  // color: Colors.redAccent,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),


                  ),
                  child:TextButton(
                    onPressed: () async{
                      // await Navigator.push(context,
                      //     MaterialPageRoute(builder: (context)=>AuthScreen()));
                      if(FirebaseAuth.instance.currentUser!=null){
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }
                      else{
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>AuthScreen()));
                      }
                    },
                    child:Text('Explore your journey',
                    style: TextStyle(
                      fontFamily: 'Lobster-Regular',
                      color: Colors.amber,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0
                    ),)
                  )
                )

              ],
            ),
          )
        )
      )
    );
  }
}
