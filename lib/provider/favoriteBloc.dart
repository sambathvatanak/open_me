import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Favorite with ChangeNotifier{
   String province;
   String userUID;
   final List<String> saveProvince = List<String>();

   addProvince(String name, String uid, String latin, String khmer, String east, String west, String south, String north, String index, String desc, String district, String commune, String village, String lat, String lng){
      saveProvince.add(latin);
      var collection = FirebaseFirestore.instance.collection('users');
      collection
          .doc(latin+uid)
          .set({"uid": uid,"name": name, "latin": latin, "khmer": khmer, "east": east, "west": west, "south": south, "north": north, "index": index, "desc": desc, "district": district, "commune": commune, "village": village, "lat": lat, "lng": lng})
          .then((_) => print('Added'))
          .catchError((error) => print('Add failed: $error'));
      notifyListeners();
   }

   removeProvince(String name, String uid){
      saveProvince.remove(name);
      FirebaseFirestore.instance.collection("users").doc(name+uid).delete().then((value) => print('deleted'))
      .catchError((error) => print("Failed to delete user: $error"));
      notifyListeners();
   }

   clearListProvince(){
      saveProvince.clear();
   }

   dataOnCloud (uid) async {
      // var uid = await fbUserNew.uid;
      await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get()
          .then((QuerySnapshot querySnapshot) {
         querySnapshot.docs.forEach((doc) {
            if(!saveProvince.contains(doc['latin'])){
               saveProvince.add(doc['latin']);
            }
         });
      });
   }

}