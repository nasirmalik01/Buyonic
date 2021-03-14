import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> editProfileDbValues({
  User user,
  String address,
  String dob,
  String phone,
  TextEditingController addressController,
  TextEditingController dobController,
  TextEditingController phoneController,
  String account,
  bool isEmail = false,
  String emailPhotoUrl
}) async {
  await FirebaseFirestore.instance
      .collection('Buyonic')
      .doc('Users')
      .collection(account)
      .doc(user.uid)
      .set({
    'name': user.displayName,
    'profile_pic': isEmail == true ? emailPhotoUrl : user.photoURL,
    'email': user.email,
    'type': account,
    'Address': addressController == null ? address : addressController.text,
    'DOB': dobController == null ? dob : dobController.text,
    'Phone': phoneController == null ? phone : phoneController.text,

  });


}
