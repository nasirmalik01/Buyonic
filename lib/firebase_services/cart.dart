import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> removeCart({QueryDocumentSnapshot snapshotData, User user}) async {
  final category = snapshotData.get('Category');
  final prodID = snapshotData.get('ProdID');
  await FirebaseFirestore.instance
      .collection('Cart')
      .doc('Data')
      .collection(user.uid)
      .doc(snapshotData.id)
      .delete();

  final itemCheckSnapshotData = await FirebaseFirestore.instance
      .collection('Admin')
      .doc('Data')
      .collection(category)
      .doc(prodID)
      .get();
  if (itemCheckSnapshotData.data() != null) {
    FirebaseFirestore.instance
        .collection('Admin')
        .doc('Data')
        .collection(category)
        .doc(prodID)
        .set({
      'AddToCart': {user.uid: false}
    }, SetOptions(merge: true)).then((value) {});
  }
}

Future<void> addCounterCart(
    {QueryDocumentSnapshot snapshotData, User user}) async {
  int counter = snapshotData.get('Quantity');
  int discPrice = int.parse(snapshotData.get('DiscountedPrice'));

  counter++;
  await FirebaseFirestore.instance
      .collection('Cart')
      .doc('Data')
      .collection(user.uid)
      .doc(snapshotData.id)
      .set({'Quantity': counter, 'SubTotal': discPrice*counter}, SetOptions(merge: true));
}

Future<void> subCounterCart(
    {QueryDocumentSnapshot snapshotData, User user}) async {
  int counter = snapshotData.get('Quantity');
  int discPrice = int.parse(snapshotData.get('DiscountedPrice'));

  if(counter>1) counter--;
  await FirebaseFirestore.instance
      .collection('Cart')
      .doc('Data')
      .collection(user.uid)
      .doc(snapshotData.id)
      .set({'Quantity': counter, 'SubTotal': discPrice*counter}, SetOptions(merge: true));
}

// Future<void> checkout({QueryDocumentSnapshot snapshotData, User user,  int length}) async {
//   int total= 0;
//   List<Map<String, dynamic>> productList = List();
//
//   for (int i = 0; i < length; i++) {
//     String category = snapshotData[i].get('Category');
//     String prodId = snapshotData[i].get('ProdID');
//     String productName = snapshotData[i].get('ProductName');
//     int quantity = snapshotData[i].get('Quantity');
//     String price = snapshotData[i].get('DiscountedPrice');
//     int budget = (int.parse(price)) * quantity;
//     total = total + budget;
//     productList.add({
//       'productName': productName,
//       'Quantity': quantity,
//       'Price': price
//     }
//     );
//     await FirebaseFirestore
//         .instance
//         .collection('Admin')
//         .doc('Data')
//         .collection(category)
//         .doc(prodId).get();
//
//     await FirebaseFirestore.instance
//         .collection('Admin')
//         .doc('Data')
//         .collection(category)
//         .doc(prodId)
//         .set({
//       'AddToCart': {user.uid: false}
//     }, SetOptions(merge: true)).then((_) =>
//     {
//       FirebaseFirestore.instance
//           .collection('Cart')
//           .doc('Data')
//           .collection(user.uid)
//           .doc(snapshotData[i].id)
//           .delete()
//     });
//   }
//
//   int totalPayment = total+200;
//   await FirebaseFirestore.instance.collection('Checkout').add({
//     'productsInfo': productList,
//     'TotalPayment': totalPayment
//   });
// }