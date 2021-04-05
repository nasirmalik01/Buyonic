import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> getProfileInfo({String accountType, User user}) async{
  final profileSnapData = await FirebaseFirestore.instance.collection('Buyonic')
        .doc('Users').collection(accountType)
        .doc(user.uid).get();

  String address = profileSnapData['Address'];
  String phone = profileSnapData['Phone'];

  if(address == 'Not set' || address.trim().isEmpty ||  phone == 'Not set' || phone.trim().isEmpty) {
    return true;
  }
  return false;
}

