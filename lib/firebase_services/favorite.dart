import 'package:buyonic/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> doFavorite(
    {QueryDocumentSnapshot snapshot,
    String collection,
    BuildContext context}) async {
  final _fireStore = FirebaseFirestore.instance;
  User _user = FirebaseAuth.instance.currentUser;
  final id = snapshot.id;
  bool fav = false;

  Map<dynamic,dynamic> favSnapshot = snapshot.get('Favorites');
  int length= favSnapshot.values.length;
  List<dynamic> keys = favSnapshot.keys.toList();
  List<dynamic> values = favSnapshot.values.toList();
  print('Okay: $length');
  for(int i=0;i<length; i++){
    if(keys[i] == _user.uid){
      print(fav);
      fav = values[i];
    }

  }

  _fireStore
      .collection('Admin')
      .doc('Data')
      .collection(collection)
      .doc(id)
      .set({
    'Favorites': {_user.uid: !fav}
  }, SetOptions(merge: true)).then((value) {});




  //Adding to favorites
  if (!fav) {
    _fireStore
        .collection('Favorites')
        .doc('Data')
        .collection(_user.uid)
        .doc(id)
        .set({
      'ProductName': snapshot.get('ProductName'),
      'DiscountedPrice': snapshot.get('DiscountedPrice'),
      'ImageURL': snapshot.get('ImageURL'),
      'Category': snapshot.get('Category'),
      'dateTime': DateTime.now(),
      'ProdId': id,
    });
    showSnackbar(context: context, content: 'Added to Wishlist');
  }

  if (fav) {
    _fireStore
        .collection('Favorites')
        .doc('Data')
        .collection(_user.uid)
        .doc(id)
        .delete();
    showSnackbar(context: context, content: 'Removed from Wishlist');
  }
}
