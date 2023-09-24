import 'package:flutter/material.dart';

String userId ="";
String userEmail ="";
String userImageUrl = "";
String getUserName = "";

String adUserName = "";
String adUserImageUrl = "";

const KGradientStyle= LinearGradient(
    colors:[
      Colors.blueAccent,
      Colors.redAccent
    ],
    tileMode: TileMode.clamp,
    begin: FractionalOffset(0.0,0.0),
    end:FractionalOffset(1.0,0.0),
    stops: [0.0,1.0]

);