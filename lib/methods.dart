import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackbar({String content, BuildContext context}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
        duration: const Duration(seconds: 1),
      content: Text(content),
      action: SnackBarAction(
          label: 'Dismiss',textColor: Colors.orange,
          onPressed: () {
            Scaffold.of(context).hideCurrentSnackBar();
          }
      )
    ),
  );
}

bool isFavorite({QueryDocumentSnapshot snapshot}){
  bool fav = false;
  User _user = FirebaseAuth.instance.currentUser;

  if( snapshot.data().containsKey('Favorites') == true) {
    Map<dynamic, dynamic> favSnapshot = snapshot.get('Favorites');


    int length = favSnapshot.values.length;
    List<dynamic> keys = favSnapshot.keys.toList();
    List<dynamic> values = favSnapshot.values.toList();
    print('Okay: $length');
    for (int i = 0; i < length; i++) {
      if (keys[i] == _user.uid) {
        fav = values[i];
      }
    }
    return fav;
  }else{
    return false;
  }
}