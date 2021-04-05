import 'package:rating_bar/rating_bar.dart';

import 'package:buyonic/model/shipment.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/shipment_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShipmentScreen extends StatefulWidget {
  @override
  _ShipmentScreenState createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  User _user;
  double _rating = 1;
  String feedback = '';
  TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: SpinKitFadingCircle(
              color: Colors.deepOrange,
            ));
          }

          final snapshotData = snapshot.data.docs;

          return snapshotData.length == 0
              ? Center(
                  child: Text('There are no pending shipments'),
                )
              : ListView.builder(
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    List<Shipment> shipment = [];
                    List<dynamic> productsInfoList =
                        snapshotData[index].get('ProductsInfo');
                    productsInfoList.forEach((data) {
                      shipment.add(Shipment(
                        productName: data['productName'],
                        price: data['Price'],
                        quantity: data['Quantity'],
                        imageURL: data['ImageURL']
                      ));
                    });
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                    itemCount: shipment.length,
                                    itemBuilder: (context, index){
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          imageShipment(
                                              context: context,
                                              imageUrl: '${shipment[index].imageURL}'),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4.0),
                                                child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: titleText(title: '${shipment[index].productName}')),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4.0),
                                                child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: titleText5(title:  'Quantity: ${shipment[index].quantity.toString()}')),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 4.0),
                                                child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: titleText3(title: 'PKR: ${shipment[index].price}')),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              Divider(color: Colors.grey, indent: 20, endIndent: 20,),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: 'Total Payment: ')),
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: 'PKR: ${snapshotData[index].get('TotalPayment')}')),
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: 'Status: ')),
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: '${snapshotData[index].get('Status')}')),
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: 'Delivery Date: ')),
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: titleText6(title: '${snapshotData[index].get('DeliveryDate')}')),
                                      ],
                                    ),
                                    feedback.trim().isEmpty ?
                                      snapshotData[index].get('Status') ==
                                          'Delivered' ? Column(
                                        children: [
                                          SizedBox(height: 10,),
                                          Container(
                                            alignment: Alignment.center,
                                            child: RaisedButton(
                                              color: Colors.deepOrangeAccent,
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                  horizontal: 70.0,),
                                                child: Text('Order Received',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Raleway',
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 16
                                                  ),),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (
                                                        BuildContext context) {
                                                      return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .circular(
                                                                  15.0)),
                                                          child: Container(
                                                            height: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .height * 0.55,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                headingFeedback(
                                                                    title: 'Show Your Feedback',
                                                                    context: context),
                                                                SizedBox(
                                                                  height: 40,),
                                                                RatingBar(
                                                                  onRatingChanged: (rating) {
                                                                    setState(() => _rating = rating);
                                                                    },
                                                                  filledIcon: Icons.star,
                                                                  emptyIcon: Icons.star_border,
                                                                  halfFilledIcon: Icons.star_half,
                                                                  isHalfAllowed: true,
                                                                  filledColor: Colors.deepOrange,
                                                                  emptyColor: Colors.blueGrey,
                                                                  halfFilledColor: Colors.amberAccent,
                                                                  size: 45,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 16.0,
                                                                      bottom: 26,
                                                                      left: 20,
                                                                      right: 20),
                                                                  child: feedbackInputField(
                                                                    controller: _feedbackController,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width *
                                                                      0.7,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          25),
                                                                      color: Colors
                                                                          .lightBlue,
                                                                      gradient: LinearGradient(
                                                                          colors: [
                                                                            Color(
                                                                                0xFFFF4828),
                                                                            Color(
                                                                                0xFFFE8D03),
                                                                          ])),
                                                                  child: FlatButton(
                                                                      child: Text(
                                                                        'Submit',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Nunito',
                                                                            fontSize: 18,
                                                                            color: Colors
                                                                                .white),
                                                                      ),
                                                                      onPressed: () {
                                                                        if(_feedbackController.text.trim().isEmpty) return;
                                                                        setState(() {
                                                                          feedback = _feedbackController.text;
                                                                        });
                                                                        Navigator.pop(context);

                                                                        // FirebaseFirestore.instance
                                                                        //     .collection('Shipment')
                                                                        //     .doc('Data').collection(_user.uid)
                                                                        //     .doc(snapshotData[index].id)
                                                                        //     .set({
                                                                        //   'Rating': _rating,
                                                                        //   'Feedback': _feedbackController.text
                                                                        // }, SetOptions(merge: true));
                                                                      }),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        ],
                                      ) : Container()
                                    :
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'My Feedback',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: titleText6(title: 'Rating: ')),
                                              RatingBar(
                                                onRatingChanged: (rating) {
                                                },
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                                halfFilledIcon: Icons.star_half,
                                                isHalfAllowed: true,
                                                filledColor: Colors.deepOrange,
                                                emptyColor: Colors.blueGrey,
                                                halfFilledColor: Colors.amberAccent,
                                                size: 20,
                                                initialRating: _rating,

                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              titleText6(title: 'Feedback: '),
                                              Container(
                                                  width: 140,
                                                  child: titleText6(title: feedback)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        });
  }

  Stream<QuerySnapshot> getStream() {
    final _fireStore = FirebaseFirestore.instance;
    return _fireStore
        .collection('Shipment')
        .doc('Data')
        .collection(_user.uid)
        .snapshots();
  }
}
