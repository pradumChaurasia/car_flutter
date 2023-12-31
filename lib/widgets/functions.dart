import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      return true;
    }else{
      return false;
    }
  }
  Future<void> addData(carData) async {
    if(isLoggedIn()){
      FirebaseFirestore.instance.collection('cars').add(carData).catchError((e){
        print(e);
      });
    }
    else{
      print('You Need To be SignIn');
    }
  }
  getData() async{
    return await FirebaseFirestore.instance.collection('cars').orderBy("time",descending: true).get();
  }
  updateData(selectedDoc,newValue){
    FirebaseFirestore.instance.collection('cars').doc(selectedDoc).update(newValue).catchError((e){
      print(e);
    });
  }
  deleteData(docId){
    FirebaseFirestore.instance.collection('cars').doc(docId).delete().catchError((e){
      print(e);
    });
  }

}