import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyonic/screens/chat_screen.dart';

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

void onMessageTap({BuildContext context}){
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChattingScreen()
  ));
}

Future<void> messageSent({String text, String imageUrl}) async {
  final _fireStore = FirebaseFirestore.instance;
  User _user = FirebaseAuth.instance.currentUser;


  await _fireStore.collection('Messages').doc(_user.uid)
  .collection('F8ZVqZXavnbNsfsTRrmFJo8Spl22').add({
      'Text': text,
      'SenderID': _user.uid,
      'Type': 'text',
      'DateTime': DateTime.now()
  }).then((value) => {
   _fireStore.collection('Messages').doc('F8ZVqZXavnbNsfsTRrmFJo8Spl22')
      .collection(_user.uid).add({
     'Text': text,
     'SenderID': _user.uid,
     'Type': 'text',
     'DateTime': DateTime.now()
  })
  });
  String displayName;
  String userEmail;
  String email;
  if(_user.displayName!=null && _user.displayName!= ""){
    displayName = _user.displayName;
  }else{
    userEmail = _user.email;
  }
  if(userEmail != null) {
    String splittingEmail = userEmail.substring(0, userEmail.indexOf('@'));
    email = splittingEmail[0].toUpperCase() + splittingEmail.substring(1);
  }
  await _fireStore.collection('Chats').doc('Data')
  .collection('F8ZVqZXavnbNsfsTRrmFJo8Spl22').doc(_user.uid)
  .set({
    'DisplayName': displayName == null ? email
        : displayName.substring(0, displayName.indexOf(' ')),
    'LastText': text,
    'ImageUrl': _user.photoURL != null ? _user.photoURL : imageUrl,
    'DatTime': DateTime.now(),
    'SenderID': _user.uid,
    'Type': 'text'
  });

}

// final _fireStore = FirebaseFirestore.instance;
// final User _user = FirebaseAuth.instance.currentUser;
// var url;
//
// @override
// void initState() {
//  getImageUrl();
//   super.initState();
// }
//
// getImageUrl() async {
//   if(_user.photoURL == null){
//     await _fireStore.collection('Buyonic').doc('Users')
//         .collection('Email').doc(_user.uid).get()
//         .then((snapshotData) => {
//     setState(() => url = snapshotData.data()['profile_pic'])
//     });
//
//   }
// }
