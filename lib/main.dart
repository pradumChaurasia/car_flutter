import 'package:car_flutter/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_flutter/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:car_flutter/screens/home_screen.dart';
// import 'screens/profile_screen.dart';
import 'package:car_flutter/screens/profile_screen.dart';
import 'package:car_flutter/screens/search_screen.dart';
import 'package:car_flutter/screens/auth_screen.dart';
void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),

        initialRoute: SplashScreen.id,
        routes:{

          SplashScreen.id:(context)=>SplashScreen(),

          HomeScreen.id:(context)=>HomeScreen(),

          ProfileScreen.id:(context)=>ProfileScreen(),

          SearchCar.id:(context)=>SearchCar(),

          AuthScreen.id:(context)=>AuthScreen(),
        },
    );

  }
}
