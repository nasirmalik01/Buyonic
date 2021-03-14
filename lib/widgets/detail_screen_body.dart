import 'package:buyonic/firebase_services/favorite.dart';
import 'package:buyonic/methods.dart';
import 'package:buyonic/screens/DetailScreen.dart';
import 'package:buyonic/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget detailBodyWidget({String collection}) {
  final _fireStore = FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('Admin')
          .doc('Data')
          .collection(collection).orderBy('DateTime', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.deepOrange,
            ),
          );
        }

        final snapshotData = snapshot.data.docs;

        return snapshotData.length == 0
            ? Center(
                child: Text('No Products Data'),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemCount: snapshotData.length,
                  itemBuilder: (ctx, index) {
                    return productCard(
                        context: context,
                        imageURL: snapshotData[index].get('ImageURL'),
                        productName: snapshotData[index].get('ProductName'),
                        discountedPrice:
                            snapshotData[index].get('DiscountedPrice'),
                        orignalPrice: snapshotData[index]
                                    .data()
                                    .containsKey('OrignalPrice') ==
                                true
                            ? snapshotData[index].get('OrignalPrice')
                            : '',
                        isFav: isFavorite(snapshot: snapshotData[index]) ?? false,
                        onFavPress: () {
                          doFavorite(collection: collection, snapshot: snapshotData[index], context: context);
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      snapshot: snapshotData[index],
                                      collection: collection,
                                      fav: isFavorite(snapshot: snapshotData[index]))));
                        });
                  },
                ),
              );
      });
}
