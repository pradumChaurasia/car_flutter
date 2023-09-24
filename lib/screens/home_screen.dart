import 'package:car_flutter/components/customTextField.dart';
import 'package:car_flutter/screens/profile_screen.dart';
import 'package:car_flutter/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_flutter/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_flutter/constants.dart';
import 'package:car_flutter/widgets/functions.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'dart:io' show Platform;
import 'package:car_flutter/widgets/image_widget.dart';


class HomeScreen extends StatefulWidget {
  static const id='home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth= FirebaseAuth.instance;
  late String userName;
  late  String userNumber;
  late String carPrice;
  late  String carModel;
  late  String carColor;
  late  String description;
  late  String urlImage;
  late String carLocation;
  QuerySnapshot? cars;

  CarMethods carObj = new CarMethods();

  Future showDialogForAddingData() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            title: Text(
              "Post a New Ad",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Bebas',
                  letterSpacing: 2.0),

            ),
            content:SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Your Name'),
                    onChanged: (value){
                      this.userName = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Your Phone Number'),
                    onChanged: (value){
                      this.userNumber = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Price'),
                    onChanged: (value){
                      this.carPrice = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Name'),
                    onChanged: (value){
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Color'),
                    onChanged: (value){
                      this.carColor = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Location'),
                    onChanged: (value){
                      this.carLocation = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Description'),
                    onChanged: (value){
                      this.description = value;
                    },
                  ),

                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Image URL'),
                    onChanged: (value){
                      this.urlImage = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    backgroundColor: Colors.amberAccent
                ),
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  backgroundColor: Colors.amberAccent
                ),
                child: Text('Add Now'),
                onPressed:(){
                  Map<String,dynamic> carData ={
                    'userName':this.userName,
                    'uId':userId,
                    'userNumber':this.userNumber,
                    'carPrice':this.carPrice,
                    'carModel':this.carModel,
                    'carColor':this.carColor,
                    'carLocation':this.carLocation,
                    'description':this.description,
                    'urlImage':this.urlImage,
                    'imgPro':userImageUrl,
                    'time':DateTime.now(),
                  };
                  carObj.addData(carData).then((value){
                    print('Data added Successfully');
                    // Navigator.push(context,MaterialPageRoute(builder:(context) => HomeScreen()));
                    Navigator.pushNamed(context, HomeScreen.id);
                  }).catchError((onError){
                    print(onError);
                  });
                },

              ),
            ],
          );
        }
    );
  }
  Future showDialogForUpdateData(selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(
              "Update Data",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Bebas',
                  letterSpacing: 2.0),

            ),
            content:SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Your Name'),
                    onChanged: (value){
                      this.userName = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Your Phone Number'),
                    onChanged: (value){
                      this.userNumber = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Price'),
                    onChanged: (value){
                      this.carPrice = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Name'),
                    onChanged: (value){
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Color'),
                    onChanged: (value){
                      this.carColor = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Location'),
                    onChanged: (value){
                      this.carLocation = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Car Description'),
                    onChanged: (value){
                      this.description = value;
                    },
                  ),

                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Image URL'),
                    onChanged: (value){
                      this.urlImage = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('Update Now'),
                onPressed:(){
                  Navigator.pop(context);
                  Map<String,dynamic> carData ={
                    'userName':this.userName,
                    'userNumber':this.userNumber,
                    'carPrice':this.carPrice,
                    'carModel':this.carModel,
                    'carColor':this.carColor,
                    'carLocation':this.carLocation,
                    'description':this.description,
                    'urlImage':this.urlImage,
                  };
                  carObj.updateData(selectedDoc,carData).then((value){
                    print('Data Updated Successfully');
                    Navigator.push(context,MaterialPageRoute(builder:(context) => HomeScreen()));
                  }).catchError((onError){
                    print(onError);
                  });
                },

              ),
            ],
          );
        }
    );
  }

  getMyData(){
    FirebaseFirestore.instance.collection('users').doc(userId).get().then((results){
      setState(() {
        userImageUrl = results.data()!['imgPro'];
        getUserName = results.data()!['userName'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    userEmail = FirebaseAuth.instance.currentUser!.email!;

    carObj.getData().then((results){
      setState(() {
        cars = results;
      });
    });

    getMyData();
  }


  @override
  Widget build(BuildContext context) {

    double _screeWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;

    Widget showCarsList()  {
      var cars = this.cars;

      if(cars != null){
        return ListView.builder(
          itemBuilder:(context,i){
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: (){
                        Route newRoute = MaterialPageRoute(builder:(_) => ProfileScreen(sellerId: cars.docs[i]['uId'],),);
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(cars.docs[i]['imgPro']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    title: GestureDetector(
                      onTap: (){
                        Route newRoute = MaterialPageRoute(builder:(_)=>ProfileScreen(sellerId: cars.docs[i]['uId'],));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Text(cars.docs[i]['userName']),
                    ),
                    subtitle: GestureDetector(
                      onTap: (){
                        Route newRoute = MaterialPageRoute(builder:(_)=>ProfileScreen(sellerId: cars.docs[i]['uId'],));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(

                            child: Text(
                              cars.docs[i]['carLocation'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.0,),
                          Icon(Icons.location_pin,color: Colors.grey,),
                        ],
                      ),
                    ),
                    trailing:
                    cars.docs[i]['uId'] == userId ?
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(cars.docs[i]['uId'] == userId){
                              showDialogForUpdateData(cars.docs[i].id);
                            }
                          },
                          child: Icon(Icons.edit_outlined),
                        ),
                        SizedBox(width: 20.0,),
                        GestureDetector(
                          onDoubleTap: (){
                            if(cars.docs[i]['uId'] ==userId){
                              carObj.deleteData(cars.docs[i].id);
                              Navigator.push(context,MaterialPageRoute(builder:(BuildContext c)=>HomeScreen()));
                            }
                          },
                          child: Icon(Icons.delete_forever_sharp),
                        ),
                      ],
                    )
                        :Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(16.0),
                    child: Image.network(cars.docs[i]['urlImage'],fit: BoxFit.fill,),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                        '\$' +cars.docs[i]['carPrice'],
                        style:TextStyle(
                          fontFamily:"Bebas",
                          letterSpacing:2.0,
                          fontSize:24,
                        )
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.directions_car),
                            Padding(padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(cars.docs[i]['carModel']),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            Padding(padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(tAgo.format((cars.docs[i]['time']).toDate())),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.directions_car),
                            Padding(padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(cars.docs[i]['carColor']),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined),
                            Padding(padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                child: Text(cars.docs[i]['userNumber']),
                                alignment: Alignment.topLeft,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                    child: Text(
                      cars.docs[i]['description'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color:Colors.blueAccent.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),

                ],
              ),
            );
          },
          itemCount: cars.docs.length,
          padding: EdgeInsets.all(8.0),
        );
      }
      else{
        return Text('Loading...');
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh,color: Colors.white),
          onPressed: (){
            Route newRoute =MaterialPageRoute(builder: (_) => HomeScreen());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        actions: [
          TextButton(
            onPressed: (){
              Route newRoute =MaterialPageRoute(builder: (_) => ProfileScreen(sellerId: userId,));
              Navigator.pushReplacement(context, newRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.person,color: Colors.white,),
            ),
          ),
          TextButton(
            onPressed: (){
              Route newRoute =MaterialPageRoute(builder: (_) => SearchCar());
              Navigator.pushReplacement(context, newRoute);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.search,color: Colors.white,),
            ),
          ),
          TextButton(
            onPressed: (){
              auth.signOut().then((_){
                Route newRoute =MaterialPageRoute(builder: (_) => AuthScreen());
                Navigator.pushReplacement(context, newRoute);

              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.login_outlined,color: Colors.white,),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: new BoxDecoration(

            gradient: new LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            ),
          ),
        ),
        title: Text('Home Page'),
        centerTitle:Platform.isAndroid || Platform.isIOS ?false : true,
      ),
      body: Center(
        child: Container(
          width:Platform.isAndroid || Platform.isIOS ? _screeWidth  : _screeWidth*.6,
          child:  showCarsList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Post',
        child: Icon(Icons.add),
        onPressed: (){
          showDialogForAddingData();
        },
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   static const id = 'home_screen';
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   FirebaseAuth auth= FirebaseAuth.instance;
//   late String userName;
//   late  String userNumber;
//   late String carPrice;
//   late  String carModel;
//   late  String carColor;
//   late  String description;
//   late  String urlImage;
//   late String carLocation;
//   QuerySnapshot? cars;
//
//
//   CarMethods carObj = CarMethods();
//
//   Future showDialogForAddingData() async{
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context){
//           return AlertDialog(
//             title: Text(
//               "Post a New Ad",
//               style: TextStyle(
//                   fontSize: 24,
//                   fontFamily: 'Bebas',
//                   letterSpacing: 2.0),
//
//             ),
//             content:Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Your Name'),
//                   onChanged: (value){
//                     this.userName = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Your Phone Number'),
//                   onChanged: (value){
//                     this.userNumber = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Price'),
//                   onChanged: (value){
//                     this.carPrice = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Name'),
//                   onChanged: (value){
//                     this.carModel = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Color'),
//                   onChanged: (value){
//                     this.carColor = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Location'),
//                   onChanged: (value){
//                     this.carLocation = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Description'),
//                   onChanged: (value){
//                     this.description = value;
//                   },
//                 ),
//
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Image URL'),
//                   onChanged: (value){
//                     this.urlImage = value;
//                   },
//                 ),
//               ],
//             ),
//             actions: [
//               ElevatedButton(
//                 child: Text('Cancel'),
//                 onPressed: (){
//                   Navigator.pop(context);
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Add Now'),
//                 onPressed:(){
//                   Map<String,dynamic> carData ={
//                     'userName':this.userName,
//                     'uId':userId,
//                     'userNumber':this.userNumber,
//                     'carPrice':this.carPrice,
//                     'carModel':this.carModel,
//                     'carColor':this.carColor,
//                     'carLocation':this.carLocation,
//                     'description':this.description,
//                     'urlImage':this.urlImage,
//                     'imgPro':userImageUrl,
//                     'time':DateTime.now(),
//                   };
//                   carObj.addData(carData).then((value){
//                     print('Data added Successfully');
//                     Navigator.push(context,MaterialPageRoute(builder:(context) => HomeScreen()));
//                   }).catchError((onError){
//                     print(onError);
//                   });
//                 },
//
//               ),
//             ],
//           );
//         }
//     );
//   }
//   Future showDialogForUpdateData(selectedDoc) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context){
//           return AlertDialog(
//             title: Text(
//               "Update Data",
//               style: TextStyle(
//                   fontSize: 24,
//                   fontFamily: 'Bebas',
//                   letterSpacing: 2.0),
//
//             ),
//             content:Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Your Name'),
//                   onChanged: (value){
//                     this.userName = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Your Phone Number'),
//                   onChanged: (value){
//                     this.userNumber = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Price'),
//                   onChanged: (value){
//                     this.carPrice = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Name'),
//                   onChanged: (value){
//                     this.carModel = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Color'),
//                   onChanged: (value){
//                     this.carColor = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Location'),
//                   onChanged: (value){
//                     this.carLocation = value;
//                   },
//                 ),
//                 SizedBox(height: 5.0),
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Car Description'),
//                   onChanged: (value){
//                     this.description = value;
//                   },
//                 ),
//
//                 TextField(
//                   decoration: InputDecoration(hintText: 'Enter Image URL'),
//                   onChanged: (value){
//                     this.urlImage = value;
//                   },
//                 ),
//               ],
//             ),
//             actions: [
//               ElevatedButton(
//                 child: Text('Cancel'),
//                 onPressed: (){
//                   Navigator.pop(context);
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Update Now'),
//                 onPressed:(){
//                   Navigator.pop(context);
//                   Map<String,dynamic> carData ={
//                     'userName':this.userName,
//                     'userNumber':this.userNumber,
//                     'carPrice':this.carPrice,
//                     'carModel':this.carModel,
//                     'carColor':this.carColor,
//                     'carLocation':this.carLocation,
//                     'description':this.description,
//                     'urlImage':this.urlImage,
//                   };
//                   carObj.updateData(selectedDoc,carData).then((value){
//                     print('Data Updated Successfully');
//                     Navigator.push(context,MaterialPageRoute(builder:(context) => HomeScreen()));
//                   }).catchError((onError){
//                     print(onError);
//                   });
//                 },
//
//               ),
//             ],
//           );
//         }
//     );
//   }
//
//
//   // Future<void> showDialogForAddingData() async {
//   //   return showDialog(
//   //     context: context, // Use the correct context here
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         elevation: 10.0,
//   //         shape:
//   //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
//   //         title: Text(
//   //           'Post a New Ad',
//   //           style: TextStyle(
//   //             fontSize: 24.0,
//   //             fontFamily: 'BebasNeue-Regular',
//   //             letterSpacing: 2.0,
//   //           ),
//   //         ),
//   //         content: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: <Widget>[
//   //               // Add your dialog content here
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.userName = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                   prefix: Icon(
//   //                     Icons.person,
//   //                     color: Colors.amberAccent,
//   //                   ),
//   //                   hintText: 'Enter your Name',
//   //                   contentPadding:
//   //                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   //                   enabledBorder: OutlineInputBorder(
//   //                     borderSide:
//   //                         BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                     borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                   ),
//   //                   focusedBorder: OutlineInputBorder(
//   //                     borderSide:
//   //                         BorderSide(color: Colors.amberAccent, width: 2.0),
//   //                     borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                   ),
//   //                 ),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.userNumber = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.phone,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter your Number',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carPrice = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Price',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carModel = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Price',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carColor = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Color',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carLocation = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.location_city_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Location',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.description = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.description_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Description',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.urlImage = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.camera_alt_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car URL Image',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: [
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: Text('Cancel'),
//   //             style: ElevatedButton.styleFrom(
//   //                 primary: Colors.amberAccent,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(15),
//   //                 ),
//   //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //                 textStyle: TextStyle(fontWeight: FontWeight.bold)),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               Map<String, dynamic> carData = {
//   //                 'userName': this.userName,
//   //                 'uId': userId,
//   //                 'userNummber': this.userNumber,
//   //                 'carPrice': this.carPrice,
//   //                 'carModel': this.carModel,
//   //                 'carColor': this.carColor,
//   //                 'carLocation': this.carLocation,
//   //                 'description': this.description,
//   //                 'urlImage': this.urlImage,
//   //                 'imgPro': userImageURL,
//   //                 'time': DateTime.now(),
//   //               };
//   //
//   //               try {
//   //                 var data = carObj.addData(carData);
//   //                 if (data != null) {
//   //                   print('car Data added successfully');
//   //                   Navigator.pushNamed(context, HomeScreen.id);
//   //                 } else {
//   //                   print('error in inserting data');
//   //                 }
//   //               } catch (e) {
//   //                 print(e);
//   //               }
//   //             },
//   //             child: Text('Add now'),
//   //             style: ElevatedButton.styleFrom(
//   //                 primary: Colors.amberAccent,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(15),
//   //                 ),
//   //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //                 textStyle: TextStyle(fontWeight: FontWeight.bold)),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//   //
//   // Future<void> showDialogForUpdateData(selectedDoc) async {
//   //   return showDialog(
//   //     context: context, // Use the correct context here
//   //     barrierDismissible: false,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         elevation: 10.0,
//   //         shape:
//   //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
//   //         title: Text(
//   //           'Update Ad',
//   //           style: TextStyle(
//   //             fontSize: 24.0,
//   //             fontFamily: 'BebasNeue-Regular',
//   //             letterSpacing: 2.0,
//   //           ),
//   //         ),
//   //         content: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: <Widget>[
//   //               // Add your dialog content here
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.userName = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                   prefix: Icon(
//   //                     Icons.person,
//   //                     color: Colors.amberAccent,
//   //                   ),
//   //                   hintText: 'Enter your Name',
//   //                   contentPadding:
//   //                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//   //                   enabledBorder: OutlineInputBorder(
//   //                     borderSide:
//   //                         BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                     borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                   ),
//   //                   focusedBorder: OutlineInputBorder(
//   //                     borderSide:
//   //                         BorderSide(color: Colors.amberAccent, width: 2.0),
//   //                     borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                   ),
//   //                 ),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.userNumber = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.phone,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter your Number',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carPrice = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Price',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carModel = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Price',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carColor = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.car_crash_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Color',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.carLocation = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.location_city_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Location',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.description = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.description_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car Description',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //               TextField(
//   //                 onChanged: (value) {
//   //                   this.urlImage = value;
//   //                 },
//   //                 decoration: InputDecoration(
//   //                     prefix: Icon(
//   //                       Icons.camera_alt_outlined,
//   //                       color: Colors.amberAccent,
//   //                     ),
//   //                     hintText: 'Enter Car URL Image',
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                         vertical: 10.0, horizontal: 10.0),
//   //                     enabledBorder: OutlineInputBorder(
//   //                       borderSide:
//   //                           BorderSide(color: Colors.amber.shade50, width: 1.0),
//   //                       borderRadius: BorderRadius.all(Radius.circular(13.0)),
//   //                     )),
//   //               ),
//   //               SizedBox(
//   //                 height: 5.0,
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         actions: [
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: Text('Cancel'),
//   //             style: ElevatedButton.styleFrom(
//   //                 primary: Colors.amberAccent,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(15),
//   //                 ),
//   //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //                 textStyle: TextStyle(fontWeight: FontWeight.bold)),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               Navigator.pushNamed(context, HomeScreen.id);
//   //               Map<String, dynamic> carData = {
//   //                 'userName': this.userName,
//   //                 // 'uId': userId,
//   //                 'userNummber': this.userNumber,
//   //                 'carPrice': this.carPrice,
//   //                 'carModel': this.carModel,
//   //                 'carColor': this.carColor,
//   //                 'carLocation': this.carLocation,
//   //                 'description': this.description,
//   //                 'urlImage': this.urlImage,
//   //                 // 'imgPro': userImageURL,
//   //                 // 'time': DateTime.now(),
//   //               };
//   //
//   //               try {
//   //                 var data = carObj.updateData(selectedDoc,carData);
//   //                 if (data != null) {
//   //                   print('car Data updated successfully');
//   //                   Navigator.pushNamed(context, HomeScreen.id);
//   //                 } else {
//   //                   print('error in inserting data');
//   //                 }
//   //               } catch (e) {
//   //                 print(e);
//   //               }
//   //             },
//   //             child: Text('Add now'),
//   //             style: ElevatedButton.styleFrom(
//   //                 primary: Colors.amberAccent,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(15),
//   //                 ),
//   //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //                 textStyle: TextStyle(fontWeight: FontWeight.bold)),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//
//   getMyData(){
//     FirebaseFirestore.instance.collection('users').doc(userId).get().then((results){
//       setState(() {
//         userImageUrl = results.data()!['imgPro'];
//         getUserName = results.data()!['userName'];
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     userId = FirebaseAuth.instance.currentUser!.uid;
//     userEmail = FirebaseAuth.instance.currentUser!.email!;
//
//     carObj.getData().then((results){
//       setState(() {
//         cars = results;
//       });
//     });
//
//     getMyData();
//   }
//   // final base64Image = (cars!.docs[i].data() as Map<String,dynamic>)['imgPro'];
//   @override
//   Widget build(BuildContext context) {
//     double _screenWidth = MediaQuery.of(context).size.width,
//         _screenHeight = MediaQuery.of(context).size.height;
//
//     Widget showCarsList()  {
//       var cars = this.cars;
//
//       if(cars != null){
//         return ListView.builder(
//           itemBuilder:(context,i){
//             return Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: GestureDetector(
//                       onTap: (){
//                         Route newRoute = MaterialPageRoute(builder:(_) => ProfileScreen(sellerId: cars.docs[i]['uId'],),);
//                         Navigator.pushReplacement(context, newRoute);
//                       },
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: NetworkImage(cars.docs[i]['imgPro']),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                     title: GestureDetector(
//                       onTap: (){
//                         Route newRoute = MaterialPageRoute(builder:(_)=>ProfileScreen(sellerId: cars.docs[i]['uId'],));
//                         Navigator.pushReplacement(context, newRoute);
//                       },
//                       child: Text(cars.docs[i]['userName']),
//                     ),
//                     subtitle: GestureDetector(
//                       onTap: (){
//                         Route newRoute = MaterialPageRoute(builder:(_)=>ProfileScreen(sellerId: cars.docs[i]['uId'],));
//                         Navigator.pushReplacement(context, newRoute);
//                       },
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               cars.docs[i]['carLocation'],
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 4.0,),
//                           Icon(Icons.location_pin,color: Colors.grey,),
//                         ],
//                       ),
//                     ),
//                     trailing:
//                     cars.docs[i]['uId'] == userId ?
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             if(cars.docs[i]['uId'] == userId){
//                               showDialogForUpdateData(cars.docs[i].id);
//                             }
//                           },
//                           child: Icon(Icons.edit_outlined),
//                         ),
//                         SizedBox(width: 20.0,),
//                         GestureDetector(
//                           onDoubleTap: (){
//                             if(cars.docs[i]['uId'] ==userId){
//                               carObj.deleteData(cars.docs[i].id);
//                               Navigator.push(context,MaterialPageRoute(builder:(BuildContext c)=>HomeScreen()));
//                             }
//                           },
//                           child: Icon(Icons.delete_forever_sharp),
//                         ),
//                       ],
//                     )
//                         :Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [],
//                     ),
//                   ),
//                   Padding(padding: const EdgeInsets.all(16.0),
//                     child: Image.network(cars.docs[i]['urlImage'],fit: BoxFit.fill,),
//                   ),
//                   Padding(padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                         '\$' +cars.docs[i]['carPrice'],
//                         style:TextStyle(
//                           fontFamily:"Bebas",
//                           letterSpacing:2.0,
//                           fontSize:24,
//                         )
//                     ),
//                   ),
//                   Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.directions_car),
//                             Padding(padding: const EdgeInsets.only(left: 10.0),
//                               child: Align(
//                                 child: Text(cars.docs[i]['carModel']),
//                                 alignment: Alignment.topLeft,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.watch_later_outlined),
//                             Padding(padding: const EdgeInsets.only(left: 10.0),
//                               child: Align(
//                                 child: Text(tAgo.format((cars.docs[i]['time']).toDate())),
//                                 alignment: Alignment.topLeft,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0,),
//                   Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.directions_car),
//                             Padding(padding: const EdgeInsets.only(left: 10.0),
//                               child: Align(
//                                 child: Text(cars.docs[i]['carColor']),
//                                 alignment: Alignment.topLeft,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.watch_later_outlined),
//                             Padding(padding: const EdgeInsets.only(left: 10.0),
//                               child: Align(
//                                 child: Text(cars.docs[i]['userNumber']),
//                                 alignment: Alignment.topLeft,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0,),
//                   Padding(padding: const EdgeInsets.only(left: 15.0,right: 15.0),
//                     child: Text(
//                       cars.docs[i]['description'],
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         color:Colors.blueAccent.withOpacity(0.6),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.0,),
//
//                 ],
//               ),
//             );
//           },
//           itemCount: cars.docs.length,
//           padding: EdgeInsets.all(8.0),
//         );
//       }
//       else{
//         return Text('Loading...');
//       }
//     }
//
//     // Widget showCarAd() {
//     //
//     //   if (cars != null && cars!.docs.isNotEmpty) {
//     //     return ListView.builder(
//     //       itemCount: cars!.docs.length,
//     //       itemBuilder: (context, i) {
//     //         final carData = cars!.docs[i].data() as Map<String, dynamic>;
//     //         return Card(
//     //           clipBehavior: Clip.antiAlias,
//     //           child: Center(
//     //             child: Column(children: <Widget>[
//     //               ListTile(
//     //                 leading: GestureDetector(
//     //                   onTap: () {
//     //                     Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//     //                       sellerId: carData['uid'],
//     //                     )));
//     //                   },
//     //                   child: Container(
//     //                     width: 60.0,
//     //                     height: 60.0,
//     //                     decoration: BoxDecoration(
//     //                       shape: BoxShape.circle,
//     //                       image: DecorationImage(
//     //                         image: NetworkImage(
//     //                           carData['imgPro'],
//     //                         ),
//     //                         fit: BoxFit.fill,
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 title: GestureDetector(
//     //                   onTap: () {
//     //                     Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//     //                       sellerId: carData['uid'],
//     //                     )));
//     //                   },
//     //                   child: Text(
//     //                     carData['userName'] ?? 'N/A',
//     //                   ),
//     //                 ),
//     //                 subtitle: GestureDetector(
//     //                   onTap: () {
//     //                     Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//     //                       sellerId: carData['uid'],
//     //                     )));
//     //                   },
//     //                   child: Row(
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: <Widget>[
//     //                       Expanded(
//     //                         child: Text(
//     //                           carData['carLocation'] ?? 'N/A',
//     //                           overflow: TextOverflow.ellipsis,
//     //                           style: TextStyle(color: Colors.black54),
//     //                         ),
//     //                       ),
//     //                       SizedBox(
//     //                         width: 4.0,
//     //                       ),
//     //                       Icon(
//     //                         Icons.location_pin,
//     //                         color: Colors.black54,
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //                 trailing: carData['uid'] == userId
//     //                     ? Row(
//     //                   mainAxisSize: MainAxisSize.min,
//     //                   children: <Widget>[
//     //                     GestureDetector(
//     //                       onTap: () {
//     //                         if (carData['uid'] == userId) {
//     //                           showDialogForUpdateData(cars?.docs[i].id);
//     //                         }
//     //                       },
//     //                       child: Icon(Icons.edit),
//     //                     ),
//     //                     SizedBox(
//     //                       width: 4.0,
//     //                     ),
//     //                     GestureDetector(
//     //                       onDoubleTap: () {
//     //                         if (carData['uid'] == userId) {
//     //                           carObj.deleteData(cars?.docs[i].id);
//     //                           Navigator.pushNamed(context, HomeScreen.id);
//     //                         }
//     //                       },
//     //                       child: Icon(Icons.delete_forever_outlined),
//     //                     ),
//     //                   ],
//     //                 )
//     //                     : Row(
//     //                   mainAxisSize: MainAxisSize.min,
//     //                   children: <Widget>[],
//     //                 ),
//     //               ),
//     //               Padding(
//     //                 padding: EdgeInsets.all(10.0),
//     //                 child: Base64ImageWidget(
//     //                   base64Image: carData['urlImage'] != null ? carData['urlImage'] : '', // Assuming 'urlImage' contains base64-encoded image data
//     //                 ),
//     //               ),
//     //               Padding(
//     //                 padding: EdgeInsets.only(left: 10.0),
//     //                 child: Text(
//     //                   '\$' + carData['carPrice'] ?? 'N/A',
//     //                   style: TextStyle(
//     //                     fontFamily: 'BebasNeue-Regular',
//     //                     letterSpacing: 2.0,
//     //                     fontSize: 24.0,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Padding(
//     //                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//     //                 child: Row(
//     //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                   children: <Widget>[
//     //                     Row(
//     //                       children: <Widget>[
//     //                         Icon(Icons.directions_car),
//     //                         Expanded(
//     //                           child: Padding(
//     //                             padding: EdgeInsets.only(left: 10.0),
//     //                             child: Align(
//     //                               alignment: Alignment.topLeft,
//     //                               child: Text(carData['carModel']),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                     Row(
//     //                       children: <Widget>[
//     //                         Icon(Icons.watch_later_outlined),
//     //                         Expanded(
//     //                           child: Padding(
//     //                             padding: EdgeInsets.only(left: 10.0),
//     //                             child: Align(
//     //                               alignment: Alignment.topLeft,
//     //                               child: Text(
//     //                                 tAgo.format((carData['time'] ?? 'N/A').toDate()),
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ],
//     //                 ),
//     //               ),
//     //               SizedBox(height: 10.0),
//     //               Padding(
//     //                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//     //                 child: Row(
//     //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                   children: <Widget>[
//     //                     Row(
//     //                       children: <Widget>[
//     //                         Icon(Icons.brush_outlined),
//     //                         Expanded(
//     //                           child: Padding(
//     //                             padding: EdgeInsets.only(left: 10.0),
//     //                             child: Align(
//     //                               alignment: Alignment.topLeft,
//     //                               child: Text(carData['carColor']),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                     Row(
//     //                       children: <Widget>[
//     //                         Icon(Icons.phone_android),
//     //                         Expanded(
//     //                           child: Padding(
//     //                             padding: EdgeInsets.only(left: 10.0),
//     //                             child: Align(
//     //                               alignment: Alignment.topLeft,
//     //                               child: Text(
//     //                                 carData['userNumber'],
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ],
//     //                 ),
//     //               ),
//     //               SizedBox(height: 10.0),
//     //               Padding(
//     //                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//     //                 child: Text(
//     //                   carData['description'],
//     //                   textAlign: TextAlign.justify,
//     //                   style: TextStyle(
//     //                     color: Colors.black54,
//     //                   ),
//     //                 ),
//     //               ),
//     //               SizedBox(height: 10.0),
//     //             ]),
//     //           ),
//     //         );
//     //       },
//     //     );
//     //   } else {
//     //     return Text('Loading...');
//     //   }
//     // }
//
//
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     leading: IconButton(
//     //       onPressed: () {
//     //         Navigator.pushNamed(context, HomeScreen.id);
//     //       },
//     //       icon: Icon(
//     //         Icons.refresh,
//     //         color: Colors.amber,
//     //       ),
//     //     ),
//     //     flexibleSpace: Container(
//     //       decoration: BoxDecoration(gradient: KGradientStyle),
//     //     ),
//     //     title: Text(
//     //       'Home Page',
//     //
//     //
//     //       style: TextStyle(
//     //         color: Colors.amber,
//     //       ),
//     //
//     //     ),
//     //     centerTitle: Platform.isAndroid || Platform.isIOS? false:true,
//     //
//     //     actions: <Widget>[
//     //       TextButton(
//     //         onPressed: () {
//     //           Navigator.push(context, MaterialPageRoute(builder: (context){
//     //             return ProfileScreen(sellerId: userId);
//     //           }));
//     //         },
//     //         child: Padding(
//     //             padding: EdgeInsets.all(10.0),
//     //             child: Icon(
//     //               Icons.person,
//     //               color: Colors.amber,
//     //             )),
//     //       ),
//     //       TextButton(
//     //         onPressed: () {
//     //           Navigator.pushNamed(context, SearchScreen.id);
//     //         },
//     //         child: Padding(
//     //             padding: EdgeInsets.all(10.0),
//     //             child: Icon(
//     //               Icons.search,
//     //               color: Colors.amber,
//     //             )),
//     //       ),
//     //       TextButton(
//     //         onPressed: () {
//     //           FirebaseAuth.instance.signOut();
//     //           Navigator.pushNamed(context, AuthScreen.id);
//     //         },
//     //         child: Padding(
//     //             padding: EdgeInsets.all(10.0),
//     //             child: Icon(
//     //               Icons.login_outlined,
//     //               color: Colors.amber,
//     //             )),
//     //       )
//     //     ],
//     //   ),
//     //   body: Center(
//     //       child: Container(
//     //           width: Platform.isAndroid || Platform.isIOS? _screenWidth:  _screenWidth * .5,
//     //           child: showCarAd()
//     //       ),
//     //   ),
//     //   floatingActionButton: FloatingActionButton(
//     //     backgroundColor: Colors.red.shade500,
//     //     tooltip: 'Add Post',
//     //     child: Icon(
//     //       Icons.add,
//     //       color: Colors.amberAccent,
//     //       size: 30.0,
//     //     ),
//     //     onPressed: () {
//     //       showDialogForAddingData();
//     //     },
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.refresh,color: Colors.white),
//           onPressed: (){
//             Route newRoute =MaterialPageRoute(builder: (_) => HomeScreen());
//             Navigator.pushReplacement(context, newRoute);
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: (){
//               Route newRoute =MaterialPageRoute(builder: (_) => ProfileScreen(sellerId: userId,));
//               Navigator.pushReplacement(context, newRoute);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.person,color: Colors.white,),
//             ),
//           ),
//           TextButton(
//             onPressed: (){
//               Route newRoute =MaterialPageRoute(builder: (_) => SearchCar());
//               Navigator.pushReplacement(context, newRoute);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.search,color: Colors.white,),
//             ),
//           ),
//           TextButton(
//             onPressed: (){
//               auth.signOut().then((_){
//                 Route newRoute =MaterialPageRoute(builder: (_) => AuthScreen());
//                 Navigator.pushReplacement(context, newRoute);
//
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Icon(Icons.login_outlined,color: Colors.white,),
//             ),
//           ),
//         ],
//         flexibleSpace: Container(
//           decoration: new BoxDecoration(
//
//             gradient: new LinearGradient(
//                 colors: [
//                   Colors.blueAccent,
//                   Colors.redAccent,
//                 ],
//                 begin: const FractionalOffset(0.0, 0.0),
//                 end: const FractionalOffset(1.0, 0.0),
//                 stops: [0.0,1.0],
//                 tileMode: TileMode.clamp
//             ),
//           ),
//         ),
//         title: Text('Home Page'),
//         centerTitle:Platform.isAndroid || Platform.isIOS ?false : true,
//       ),
//       body: Center(
//         child: Container(
//           width:Platform.isAndroid || Platform.isIOS ? _screenWidth  : _screenWidth*.6,
//           child:  showCarsList(),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Add Post',
//         child: Icon(Icons.add),
//         onPressed: (){
//           showDialogForAddingData();
//         },
//       ),
//     );
//   }
// }
