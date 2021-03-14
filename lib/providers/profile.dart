// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// class ProfileItems {
//   final String address;
//   final String phone;
//   final String DOB;
//
//   ProfileItems({this.address, this.phone, this.DOB});
// }
//
// class Profile with ChangeNotifier {
//
//   List<ProfileItems> _profile = [];
//
//   List<ProfileItems> get items {
//     // ignore: sdk_version_ui_as_code
//     return [..._profile];
//   }
//
//   Future<void> addAddress(
//       String uid, String displayName, String photoUrl, String email) async {
//     DocumentSnapshot documentSnapshot = await Firestore.instance
//         .collection('Buyonic')
//         .document('Users')
//         .collection('Google')
//         .document(uid)
//         .get();
//
//     if (documentSnapshot.data['type'] == 'Google') {
//       await Firestore.instance
//           .collection('Buyonic')
//           .document('Users')
//           .collection('Google')
//           .document(uid)
//           .setData({
//         'name': displayName,
//         'profile_pic': photoUrl,
//         'email': email,
//         'type': 'Google',
//         'Address': 'Khairpur',
//         'Phone': '03340803350',
//         'DOB': '27 sep 1998',
//       });
//     }
//
//     notifyListeners();
//     print('Done added');
//   }
//
//   Future<void> fetchAddress() async {
//     DocumentSnapshot _documentSnapshot = await Firestore.instance
//         .collection('Buyonic')
//         .document('Users')
//         .collection('Google')
//         .document('BQjl3UCVtnQwSqL5KlcGgONkAao2')
//         .get();
//
//     if (_documentSnapshot.data != null) {
//       final List<ProfileItems> loadedAddress = [];
//       loadedAddress.add(
//           ProfileItems(
//               address: _documentSnapshot.data['Address'],
//               phone:_documentSnapshot.data['Phone'],
//               DOB: _documentSnapshot.data['DOB']),
//       );
//       _profile = loadedAddress;
//     }
//     notifyListeners();
//   }
// }
