


import 'package:deep_collection/deep_collection.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Database  {

  final databaseReference = FirebaseDatabase.instance.ref();



  Future<void> createRecord(var cost,String des, DateTime dateTime) async {

    final prefs = await SharedPreferences.getInstance();
    String path='';
    if(prefs!=null){

      path = prefs.getString(name).toString();

    }

    print("create rec");
    databaseReference.child(path).push().set({
      'Cost': cost,
      'description': des,
      'dateTime':dateTime.toString().replaceAll(":", "_"),
      "timeStamp":DateTime.now().millisecondsSinceEpoch
    });
  }

  // void createRecordDummy(){
  //
  //   print("create rec");
  //   databaseReference.push().set({
  //     'Cost': 100,
  //     'description': "aaa",
  //     'dateTime':"2022-05-05 15_54_26.919800",
  //     "timeStamp":"7"
  //   });
  // }

  Future<Map<String,dynamic>> getData() async {

    // DatabaseEvent event = await databaseReference.orderByChild("timeStamp").once();

    Map<String,dynamic> sortedData={};
    final prefs = await SharedPreferences.getInstance();
    String path='';
    if(prefs!=null){

      path = prefs.getString(name).toString();

    }

    databaseReference.child(path)
        .orderByChild('timestamp')
        .onChildAdded
        .listen((event) {

      sortedData[event.snapshot.key.toString()]=event.snapshot.value;

    });

    await Future.delayed(Duration(seconds: 5),);



    return sortedData.deepReverse();

  }

  void updateData(){
    databaseReference.child('1').update({
      'description': 'J2EE complete Reference'
    });
  }

  Future deleteData(String key) async {

    final prefs = await SharedPreferences.getInstance();
    String path='';
    if(prefs!=null){

      path = prefs.getString(name).toString();

    }

    await databaseReference.child(path).child(key).remove();
  }
}