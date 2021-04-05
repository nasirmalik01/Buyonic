import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> removeWishList(
    {QueryDocumentSnapshot snapshotData, User user}) async {
  await FirebaseFirestore.instance.collection('Favorites').doc('Data').
  collection(user.uid).doc(snapshotData.id).delete();
  final category = snapshotData.get('Category');
  final prodID = snapshotData.get('ProdId');
  final itemCheckSnapshotData = await FirebaseFirestore.instance.collection(
      'Admin').
  doc('Data').collection(category).doc(prodID).get();
  if (itemCheckSnapshotData.data() != null) {
    FirebaseFirestore.instance
        .collection('Admin')
        .doc('Data')
        .collection(category)
        .doc(prodID)
        .set({
      'Favorites': {user.uid: false}
    }, SetOptions(merge: true)).then((value) {});
  }
}