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
             : ListView.builder(
             itemCount: snapshotData.length,
             itemBuilder: (context, index){
           return Column(
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
                                                 titleText3(title:  'PKR: ${snapshotData[index].get('DiscountedPrice')}'),
                                               ],
                                             )),
                                       ),
                                       quantityProduct(
                                           context: context,
                                           counterValue: '1',
                                           onAddTap: () {},
                                           onSubTap: () {})
                                     ],
                                   ),
                                   addToCart(context: context, onPress: (){})
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
             );
         });
        }
      ),
    );
  }
}

//
//
// Column(
// children: [
// SizedBox(
// height: MediaQuery.of(context).size.height * 0.25,
// child: Padding(
// padding: EdgeInsets.all(16),
// child: Card(
// elevation: 5,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(5)),
// child: Row(
// children: [
// imageWishList(
// context: context,
// imageUrl:
// 'https://www.gizmochina.com/wp-content/uploads/2019/03/Lenovo-ideapad-720S-Notebook-600x600.jpg'),
// Expanded(
// child: Container(
// margin: EdgeInsets.only(
// top: 12, bottom: 0, left: 10, right: 5),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// children: [
// FittedBox(
// fit: BoxFit.fitWidth,
// child: titleText(title: 'Samsung Mobile')),
// Container(
// margin: EdgeInsets.only(
// top: MediaQuery.of(context).size.height *
// 0.01),
// child: FittedBox(
// fit: BoxFit.fitWidth,
// child: Row(
// children: [
// titleText3(title: 'PKR 25000  '),
// titleText4(title: '30000'),
// ],
// )),
// ),
// quantityProduct(
// context: context,
// counterValue: '1',
// onAddTap: () {},
// onSubTap: () {})
// ],
// ),
// addToCart(context: context, onPress: (){})
// ],
// ),
// ),
// )
// ],
// ),
// ),
// ),
// )
// ],
// );