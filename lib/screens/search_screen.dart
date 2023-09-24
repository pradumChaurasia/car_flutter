import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_flutter/screens/home_screen.dart';
import 'package:car_flutter/screens/profile_screen.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:car_flutter/constants.dart';
import 'package:car_flutter/widgets/functions.dart';
import 'dart:io' show Platform;

class SearchCar extends StatefulWidget {
  static const id='search_car';
  const SearchCar({Key? key}) : super(key: key);

  @override
  _SearchCarState createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  QuerySnapshot? cars;

  Widget _buildSearchField(){
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search here...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30,),
      ),
      style: TextStyle(color: Colors.white,fontSize: 16.0,),
      onChanged: (query)=> updateSearchQuery(query),

    );
  }

  List<Widget> _buildActions(){
    if(_isSearching){
      return <Widget> [
        IconButton
          (
          onPressed: (){
            if(_searchQueryController == null || _searchQueryController.text.isEmpty){
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },

          icon:const Icon(Icons.clear),)
      ];
    }
    return <Widget>[
      IconButton(onPressed: _startSearch, icon: const Icon(Icons.search),)
    ];
  }

  _startSearch(){
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  updateSearchQuery(String newQuery){
    setState(() {
      getResults();
      searchQuery =newQuery;
    });
  }

  _stopSearching(){
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearchQuery(){
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  _buildTitle(BuildContext context){
    return Text('Search Car');
  }

  Widget _buildBackButton(){
    return IconButton(
      onPressed: (){
        Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      },
      icon: Icon(Icons.arrow_back,color:Colors.white),
    );
  }


  getResults(){
    FirebaseFirestore.instance.collection('cars')
        .where('carModel',isGreaterThanOrEqualTo: _searchQueryController.text.trim())
        .get()
        .then((results) {
      setState(() {
        cars = results;
        print("this is results" + cars!.docs[0]['carModel']);
      });
    });
  }
  //
  // getResults(){
  //   FirebaseFirestore.instance.collection('cars').
  //   where('carModel',isGreaterThanOrEqualTo: _searchQueryController.text.trim())
  //       .get().then((results){
  //         setState(() {
  //           cars=results;
  //               print(cars!.docs[0]['carModel']);
  //         });
  //   });
  // }

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
        leading: _isSearching ? const BackButton() : _buildBackButton(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [
              Colors.blueAccent,
              Colors.redAccent,
            ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width:Platform.isAndroid || Platform.isIOS ? _screeWidth  : _screeWidth*.6,
          child:  showCarsList(),
        ),
      ),
    );
  }
}

// class SearchScreen extends StatefulWidget {
//   static const id="profile_screen";
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
//
//
//
// class _SearchScreenState extends State<SearchScreen> {
//
//   TextEditingController _searchQueryController=TextEditingController();
//   bool _isSearching =false;
//   String searchQuery='';
//   FirebaseAuth auth =FirebaseAuth.instance;
//   QuerySnapshot? cars;
//   String? carModel;
//   String? carColor;
//
//   CarMethods carObj= CarMethods();
//
//   Widget _buildSearchField(){
//     return TextField(
//       controller: _searchQueryController,
//       autofocus: true,
//       decoration: InputDecoration(
//         hintText: 'Search here',
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: Colors.amber,fontSize: 16.0),
//
//       ),
//       onChanged: (query)=>updateSearchQuery(query),
//
//     );
//   }
//
//   List<Widget> _buildActions(){
//     if(_isSearching){
//       return <Widget>[
//         IconButton(onPressed: (){
//           if(_searchQueryController==null || _searchQueryController.text.isEmpty){
//             Navigator.pop(context);
//             return;
//           }
//           _clearSearchQuery();
//         }
//             , icon:Icon(Icons.clear))
//       ];
//     }
//     return <Widget>[
//       IconButton(onPressed: (){
//         _startSearch();
//       }, icon: Icon(Icons.search))
//     ];
//   }
//
//   _startSearch(){
//
//     ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
//
//     setState(() {
//       _isSearching=true;
//     });
//
//   }
//
//   _stopSearching(){
//     _clearSearchQuery();
//     setState(() {
//       _isSearching=false;
//     });
//   }
//
//   _clearSearchQuery(){
//     setState(() {
//       _searchQueryController.clear();
//       updateSearchQuery("");
//     });
//   }
//
//   _buildTitle(BuildContext context){
//     return Text('Search Car');
//   }
//
//   Widget _buildBackButton(){
//     return IconButton(onPressed: (){
//       Navigator.pushNamed(context, HomeScreen.id);
//     },
//       icon:Icon(Icons.arrow_back),color: Colors.amberAccent,);
//   }
//
//   updateSearchQuery(String newQuery){
//     setState(() {
//       getResults();
//       searchQuery=newQuery;
//     });
//   }
//
//   getResults() async {
//     var res=await FirebaseFirestore.instance.collection('cars')
//         .where('carModel',isGreaterThanOrEqualTo: _searchQueryController.text.trim()).get();
//     setState(() {
//       cars=res;
//       print('results...');
//       print("result"+(cars?.docs[0].data as Map)['carModel']);
//
//     });
//
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     double _screenWidth = MediaQuery.of(context).size.width,
//         _screenHeight = MediaQuery.of(context).size.height;
//
//     Widget showCarAd() {
//       if (cars != null) {
//         return ListView.builder(
//           itemCount: cars?.docs.length,
//           itemBuilder: (context, i) {
//             return Card(
//               clipBehavior: Clip.antiAlias,
//               child: Center(
//                 child: Column(children: <Widget>[
//                   ListTile(
//                     leading: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//                           sellerId: (cars?.docs[i].data() as Map)['uid'],
//                         )));
//                       },
//                       child: Container(
//                         width: 60.0,
//                         height: 60.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               (cars?.docs[i].data() as Map)['imgPro'] ?? 'N/A',
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                     title: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//                           sellerId: (cars?.docs[i].data() as Map)['uid'],
//                         )));
//                       },
//                       child: Text(
//                         (cars?.docs[i].data() as dynamic)['userName'] ?? 'N/A',
//                       ),
//                     ),
//                     subtitle: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(
//                           sellerId: (cars?.docs[i].data() as Map)['uid'],
//                         )));
//                       },
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Expanded(
//                             child: Text(
//                               (cars?.docs[i].data() as Map)['carLocation'] ?? 'N/A',
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(color: Colors.black54),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 4.0,
//                           ),
//                           Icon(
//                             Icons.location_pin,
//                             color: Colors.black54,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Image.network(
//                       (cars?.docs[i].data() as Map)['urlImage'] ?? 'N/A',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       '\$' + (cars?.docs[i].data() as Map)['carPrice'] ?? 'N/A',
//                       style: TextStyle(
//                         fontFamily: 'BebasNeue-Regular',
//                         letterSpacing: 2.0,
//                         fontSize: 24.0,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Icon(Icons.directions_car),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text((cars?.docs[i].data() as Map)['carModel'] ?? 'N/A'),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Icon(Icons.watch_later_outlined),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     tAgo.format(((cars?.docs[i].data() as Map)['time'] ?? 'N/A').toDate()),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Icon(Icons.brush_outlined),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text((cars?.docs[i].data() as Map)['carColor'] ?? 'N/A'),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Icon(Icons.phone_android),
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 10.0),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     (cars?.docs[i].data() as Map)['userNumber'] ?? 'N/A',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                   Padding(
//                     padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                     child: Text(
//                       (cars?.docs[i].data() as Map)['description'] ?? 'N/A',
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10.0),
//                 ]),
//               ),
//             );
//           },
//         );
//       } else {
//         return Text('Loading...');
//       }
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: _isSearching ? BackButton() : null,
//         title:_isSearching? _buildSearchField() : _buildTitle(context),
//         actions: _buildActions(),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors:[
//                   Colors.blueAccent,
//                   Colors.redAccent
//                 ],
//                 tileMode: TileMode.clamp,
//                 begin: FractionalOffset(0.0,0.0),
//                 end:FractionalOffset(1.0,0.0),
//                 stops: [0.0,1.0]
//
//             )
//           ),
//         ),
//       ),
//       body: Center(
//         child: Container(
//             width: Platform.isAndroid || Platform.isIOS? _screenWidth:  _screenWidth * .5,
//             child: showCarAd()
//         ),
//       ),
//     );
//   }
// }
