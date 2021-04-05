import 'package:buyonic/firebase_services/favorite.dart';
import 'package:buyonic/screens/detail_screen.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyonic/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'product_card.dart';

Widget productsDisplayWidget({String collection, BuildContext context}) {
  final _fireStore = FirebaseFirestore.instance;
  MediaQueryData _mediaQuery = MediaQuery.of(context);
  return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('Admin')
          .doc('Data')
          .collection(collection)
          .orderBy('DateTime', descending: true)
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
                child: SizedBox(
                  height: _mediaQuery.size.height * 0.35,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (snapshotData.length == 1 ||
                          snapshotData.length == 2 ||
                          snapshotData.length == 3 ||
                          snapshotData.length > 3)
                        productCard(
                            context: context,
                            imageURL: snapshotData[0].get('ImageURL'),
                            productName: snapshotData[0].get('ProductName'),
                            discountedPrice:
                                snapshotData[0].get('DiscountedPrice'),
                            orignalPrice: snapshotData[0]
                                        .data()
                                        .containsKey('OrignalPrice') ==
                                    true
                                ? snapshotData[0].get('OrignalPrice')
                                : '',
                            isFav: isFavorite(snapshot: snapshotData[0]),
                            onFavPress: () {
                              doFavorite(collection: collection, snapshot: snapshotData[0],context: context);
                            },
                            onTap: () {
                              String collec = collection;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          snapshot: snapshotData[0],
                                          collection: collec,
                                          fav: isFavorite(snapshot: snapshotData[0]),
                                          )));
                            }),
                      if (snapshotData.length == 2 ||
                          snapshotData.length == 3 ||
                          snapshotData.length > 3)
                        productCard(
                            context: context,
                            imageURL: snapshotData[1].get('ImageURL'),
                            productName: snapshotData[1].get('ProductName'),
                            discountedPrice:
                                snapshotData[1].get('DiscountedPrice'),
                            orignalPrice: snapshotData[1]
                                        .data()
                                        .containsKey('OrignalPrice') ==
                                    true
                                ? snapshotData[1].get('OrignalPrice')
                                : '',
                            isFav: isFavorite(snapshot: snapshotData[1]),
                            onFavPress: () {
                              doFavorite(collection: collection, snapshot: snapshotData[1],context: context);
                            },
                            onTap: () {
                              String collec = collection;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          snapshot: snapshotData[1],
                                          collection: collec,
                                          fav: isFavorite(snapshot: snapshotData[1]),
                                        )));
                            }),
                      if (snapshotData.length == 3 || snapshotData.length > 3)
                        productCard(
                            context: context,
                            imageURL: snapshotData[2].get('ImageURL'),
                            productName: snapshotData[2].get('ProductName'),
                            discountedPrice:
                                snapshotData[2].get('DiscountedPrice'),
                            orignalPrice: snapshotData[2]
                                        .data()
                                        .containsKey('OrignalPrice') ==
                                    true
                                ? snapshotData[2].get('OrignalPrice')
                                : '',
                            isFav: isFavorite(snapshot: snapshotData[2]),
                            onFavPress: () {
                              doFavorite(collection: collection, snapshot: snapshotData[2],context: context);
                            },
                            onTap: () {
                              String collec = collection;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          snapshot: snapshotData[2],
                                          collection: collec,
                                          fav: isFavorite(snapshot: snapshotData[2]),
                                        )));
                            })
                    ],
                  ),
                ),
              );
      });
}

Widget rowTitleWidget({String title, Function onTap}) {
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, right: 18, left: 18),
          child: titleText(title: title),
        ),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 18, left: 18),
            child: titleText2(
              title: 'See More >',
            ),
          ),
          onTap: onTap,
        ),
      ],
    ),
  );
}



