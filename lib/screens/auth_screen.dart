import 'package:flutter/material.dart';
import 'package:car_flutter/widgets/login.dart';
import 'package:car_flutter/widgets/register.dart';

class AuthScreen extends StatefulWidget {
  static const id='auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
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
              ),

            ),
          ),
          title: Text('Deal Car',
          style: TextStyle(
            fontSize: 60.0,
            color: Colors.amber,
            fontFamily: 'Lobster-Regular'
          ),

          ),
          centerTitle: true,


          bottom: TabBar(
            tabs: [
              Tab(
                icon:Icon(Icons.lock,
                color: Colors.amber,),
                text: 'Login',


              ),
              Tab(
                  icon:Icon(Icons.person,
                    color: Colors.amber,),
                text: "Register",
              ),

            ],
            indicatorWeight: 5.0,
            indicatorColor: Colors.amber,

          ),

        ),

        body:Container(
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
              ),

            ),
          child: TabBarView(
            children: <Widget>[
              Login(),
              Register(),

            ],
          )
        )
      ),
    );
  }
}
