import 'package:buyonic/firebase_services/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/wishlist_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class WishListScreen extends StatefulWidget {
  WishListScreen({Key key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  User _user =  FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;
  bool _isLoading = false;
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Favorites').doc('Data').collection(_user.uid).snapshots(),

          builder: (context, snapshot){
         if(!snapshot.hasData){
           return Center(
             child: SpinKitFadingCircle(
               color: Colors.deepOrange,
             ),
           );
         }

         final snapshotData = snapshot.data.docs;

         return snapshotData.length == 0
             ? Center(
           child: Text('No WishList added'),
         )
             :
         _isLoading ? Center(child: SpinKitFadingCube(color: Colors.deepOrange,),) :
         ListView.builder(
             itemCount: snapshotData.length,
             itemBuilder: (context, index){
               int discPrice = int.parse(snapshotData[index].get('DiscountedPrice')) *
                   snapshotData[index].get('Quantity');
           return Dismissible(
             key: UniqueKey(),
             direction: DismissDirection.startToEnd,
             background: backgroundDismissibleCart(),
             onDismissed: (direction) async {
              removeWishList(user: _user, snapshotData: snapshotData[index]);
               // showSnackbar(context: context, content: 'Item removed from wishlist');
             },
             child: Column(
                 children: [
                   SizedBox(
                     height: MediaQuery.of(context).size.height * 0.25,
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                       child: Card(
                         elevation: 10,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(5)),
                         child: Row(
                           children: [
                             imageWishList(
                                 context: context,
                                 imageUrl: snapshotData[index].get('ImageURL')),
                             Expanded(
                               child: Container(
                                 margin: EdgeInsets.only(
                                     top: 20, bottom: 0, left: 10, right: 10),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       children: [
                                         FittedBox(
                                             fit: BoxFit.fitWidth,
                                             child: titleText(title: snapshotData[index].get('ProductName'))),
                                         Container(
                                           margin: EdgeInsets.only(
                                               top: MediaQuery.of(context).size.height *
                                                   0.01),
                                           child: FittedBox(
                                               fit: BoxFit.fitWidth,
                                               child: Row(
                                                 children: [
                                                   titleText3(title:  'PKR: ${discPrice.toString()}'),
                                                 ],
                                               )),
                                         ),
                                         quantityProduct(
                                             context: context,
                                             counterValue:  snapshotData[index].get('Quantity').toString(),
                                             onAddTap: () async {
                                               counter = snapshotData[index].get('Quantity');

                                               counter++;
                                               await FirebaseFirestore.instance.collection('Favorites').doc('Data').
                                               collection(_user.uid).doc(snapshotData[index].id).set(
                                                   {
                                                     'Quantity': counter
                                                   }, SetOptions(merge: true));


                                             },
                                             onSubTap: () async {
                                               counter = snapshotData[index].get('Quantity');
                                               if(counter > 1) counter--;
                                               await FirebaseFirestore.instance.collection('Favorites').doc('Data').
                                               collection(_user.uid).doc(snapshotData[index].id).set(
                                                   {
                                                     'Quantity': counter
                                                   }, SetOptions(merge: true));



                                             })
                                       ],
                                     ),
                                     addToCart(context: context, onPress: () async {
                                       setState(() {
                                         _isLoading = true;
                                       });
                                       final category = snapshotData[index].get('Category');
                                       final prodID = snapshotData[index].get('ProdId');
                                       final favID = snapshotData[index].id;
                                       final itemCheckSnapshotData = await FirebaseFirestore.instance.collection('Admin').
                                       doc('Data').collection(category).doc(prodID).get();
                                       if(itemCheckSnapshotData.data() == null){
                                         await showDialog(context: context, builder: (context){
                                           return AlertDialog(title: Text('Not Available', style: TextStyle(
                                               fontFamily: 'Raleway',
                                               fontWeight: FontWeight.bold
                                           ),),
                                             content: Text('Item you selected is out of Stock', style: TextStyle(
                                                 fontFamily: 'Raleway'
                                             ),), actions: [
                                               TextButton(onPressed: (){
                                                 Navigator.pop(context);
                                               }, child: Text('Okay', style: TextStyle(
                                           fontFamily: 'Raleway',
                                           ),))
                                             ],);
                                         });

                                         FirebaseFirestore.instance.collection('Favorites').doc('Data').
                                         collection(_user.uid).doc(favID).delete();
                                         print('Data deleted');
                                         setState(() {
                                           _isLoading = false;
                                         });
                                       }else{
                                         final snapData = await _fireStore
                                             .collection('Admin')
                                             .doc('Data')
                                             .collection(snapshotData[index].get('Category'))
                                             .doc(snapshotData[index].id)
                                             .get();

                                         bool isAddToCart = false;
                                         Map<dynamic, dynamic> isAddedToCart = snapData.data()['AddToCart'];
                                         if(isAddedToCart != null) {
                                           int length = isAddedToCart.values.length;
                                           List<dynamic> keys = isAddedToCart.keys.toList();
                                           List<dynamic> values = isAddedToCart.values.toList();
                                           print('Okay: $length');
                                           for (int i = 0; i < length; i++) {
                                             if (keys[i] == _user.uid) {
                                               isAddToCart = values[i];
                                               print('IsAdded: $isAddToCart');

                                             }
                                           }
                                         }

                                         if(isAddToCart){
                                           showDialogBox();
                                           setState(() {
                                             _isLoading = false;
                                           });
                                           return;
                                         }

                                         await _fireStore.collection('Cart').doc('Data').collection(_user.uid).add({
                                           'ProductName': snapshotData[index].get('ProductName'),
                                           'DiscountedPrice': snapshotData[index].get('DiscountedPrice'),
                                           'Category': snapshotData[index].get('Category'),
                                           'ProdID': snapshotData[index].id,
                                           'ImageURL': snapshotData[index].get('ImageURL'),
                                           'Quantity': snapshotData[index].get('Quantity'),
                                           'SubTotal': int.parse(snapshotData[index].get('DiscountedPrice')) *
                                               snapshotData[index].get('Quantity'),
                                         });

                                         await _fireStore
                                             .collection('Admin')
                                             .doc('Data')
                                             .collection(snapshotData[index].get('Category'))
                                             .doc(snapshotData[index].id)
                                             .set({'AddToCart': {
                                           _user.uid: true
                                         }
                                         }, SetOptions(merge: true));

                                         await FirebaseFirestore.instance.collection('Favorites').doc('Data').
                                         collection(_user.uid).doc(snapshotData[index].id).set(
                                             {
                                               'Quantity': 1
                                             }, SetOptions(merge: true));

                                         showCartSnackbar(content: 'Item added To Cart');
                                         setState(() {
                                           _isLoading = false;
                                         });
                                       }
                                     })
                                   ],
                                 ),
                                        ),
                             )
                           ],
                         ),
                       ),
                     ),
                   )
                 ],
               ),
           );
         });
        }
      ),
    );
  }

  showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Item already added to the Cart',
              style: TextStyle(
                fontFamily: 'Raleway',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okay', style: TextStyle(
                    fontFamily: 'Raleway',
                  ),))
            ],
          );
        });
  }

  void showCartSnackbar({String content}) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(content, style: TextStyle(fontFamily: 'Nunito'),),
          action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.orange,
              onPressed: () {
                Scaffold.of(context).hideCurrentSnackBar();
              })),
    );
  }

}