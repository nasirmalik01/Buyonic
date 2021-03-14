import 'package:buyonic/widgets/details_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyonic/widgets/Widget.dart';

class DetailScreen extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;
  final collection;
  final bool fav;

  DetailScreen({this.snapshot, this.collection, this.fav});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  User _user =  FirebaseAuth.instance.currentUser;
  int counter = 1;
  bool isFav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backIcon(
                      context: context,
                      iconButton: IconButton(
                          icon: Icon(
                            isFav == null
                                ? widget.fav
                                ? Icons.favorite
                                : Icons.favorite_outline
                                : isFav
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            final id = widget.snapshot.id;
                            FirebaseFirestore.instance
                                .collection('Admin')
                                .doc('Data')
                                .collection(widget.collection)
                                .doc(id)
                                .set({
                              'Favorites': {_user.uid: !widget.fav}},
                                SetOptions(merge: true)).then((value) {
                              setState(() {
                                isFav == null
                                    ? isFav = !widget.fav
                                    : isFav = !isFav;
                              });
                              if (isFav) {
                                addFavSnackbar(id: id, content: 'Added To Wishlist');
                              }

                              if (!isFav) {
                                removeFavSnackbar(content: 'Removed From Wishlist', id: id);
                              }
                            });
                          }),
                    ),
                    detailImageWidget(
                        context: context,
                        imageUrl: widget.snapshot.get('ImageURL')),
                  ],
                ),
              ),
            ),
            productInfoRow(
              context: context,
              productName:
              widget.snapshot.get('ProductName').toString().toUpperCase(),
              discountedPrice: '${widget.snapshot.get('DiscountedPrice')} PKR',
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 16, right: 16, bottom: 30),
              child: descText(
                  title:
                  'DELL is amazing company which hands over you excellent things under remarkable and reasonable price so dont wait for the opportunity'),
            ),
            addToCartWidget(
                context: context,
                counter: counter.toString(),
                onTapAdd: () {
                  setState(() {
                    counter = counter + 1;
                  });
                },
                onTapSub: () {
                  setState(() {
                    if (counter > 1) {
                      counter = counter - 1;
                    }
                  });
                })
          ],
        ),
      ),
    );
  }

  void removeFavSnackbar({String id, String content}){
    User _user =  FirebaseAuth.instance.currentUser;
    final _fireStore = FirebaseFirestore.instance;
    _fireStore.collection('Favorites').doc('Data').collection(_user.uid).doc(id).delete();
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
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

  void addFavSnackbar({String id, String content}){
    final _fireStore = FirebaseFirestore.instance;
    _fireStore.collection('Favorites').doc('Data').collection(_user.uid).doc(id).set({
      'ProductName': widget.snapshot.get('ProductName'),
      'DiscountedPrice': widget.snapshot.get('DiscountedPrice'),
      'ImageURL': widget.snapshot.get('ImageURL'),
      'Category': widget.snapshot.get('Category'),
      'dateTime': DateTime.now(),
      'ProdId': id,
    });
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
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
}
