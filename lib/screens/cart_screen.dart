
import 'package:buyonic/firebase_services/cart.dart';
import 'package:buyonic/firebase_services/check_profile_info.dart';
import 'package:buyonic/services/payment_service.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/cart_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {


  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User _user;
  int _counter;
  int _price;
  int _shipping = 200;
  int _totalPrice = 0;
  static  dynamic secretKey;
  dynamic publishableKey;
  String accountType;

  @override
  void initState() {
    super.initState();
    StripeService.init();
    _user = FirebaseAuth.instance.currentUser;
    getAccountType();
  }

  Future<void> getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accountType = prefs.getString('type');
  }

  Future<void> getSecretAndPublishableKey() async {
    final snapshotData = FirebaseFirestore.instance.collection('PaymentService').doc('3IPJa4uYEWoaxFLFEp1y');
    await snapshotData.get().then((snapshot) => {
    setState(() {
      secretKey = snapshot.data()['secretKey'];
    })
    });
  }

  // static Map<String, String> headers = {
  //   'Authorization': 'Bearer $secretKey',
  //   'Content-Type': 'application/x-www-form-urlencoded'
  // };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Cart')
              .doc('Data')
              .collection(_user.uid)
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
            int _subTotal = 0;

            return snapshotData.length == 0
                ? Center(
                    child: Text('No Items added in Cart'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshotData.length,
                            itemBuilder: (context, index) {
                              _counter = snapshotData[index].get('Quantity');
                              int price = int.parse(
                                  snapshotData[index].get('DiscountedPrice'));
                              if (_counter > 0) {
                                _price = _counter * price;
                              }
                              _subTotal = _subTotal +
                                  snapshotData[index].get('SubTotal');
                              _totalPrice = _subTotal + _shipping;
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.startToEnd,
                                background: backgroundDismissibleCart(),
                                onDismissed: (direction) async {
                                  await removeCart(
                                      user: _user,
                                      snapshotData: snapshotData[index]);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              imageCart(
                                                  context: context,
                                                  imageUrl: snapshotData[index]
                                                      .get('ImageURL')),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 20,
                                                      bottom: 0,
                                                      left: 10,
                                                      right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          FittedBox(
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              child: titleText(
                                                                  title: snapshotData[
                                                                          index]
                                                                      .get(
                                                                          'ProductName'))),
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                top: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.25,
                                                                    child: priceCart(
                                                                        title:
                                                                            'PKR: ${_price.toString()}')),
                                                                quantityCart(
                                                                    context:
                                                                        context,
                                                                    quantity: snapshotData[
                                                                            index]
                                                                        .get(
                                                                            'Quantity')
                                                                        .toString(),
                                                                    onAddTap:
                                                                        () async {
                                                                      addCounterCart(
                                                                        snapshotData:
                                                                            snapshotData[index],
                                                                        user:
                                                                            _user,
                                                                      );
                                                                    },
                                                                    onSubTap:
                                                                        () {
                                                                      subCounterCart(
                                                                          snapshotData: snapshotData[
                                                                              index],
                                                                          user:
                                                                              _user);
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.02),
                                                          child: shippingText(
                                                              title:
                                                                  'No Reviews'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (index == snapshotData.length - 1)
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04),
                                        child: Column(
                                          children: [
                                            priceListCart(
                                                context: context,
                                                title: 'Sub Total',
                                                price:
                                                    'PKR: ${_subTotal.toString()}',
                                                isSubTotal: true),
                                            priceListCart(
                                                context: context,
                                                title: 'Shipping',
                                                price:
                                                    'PKR: ${_shipping.toString()}',
                                                isShipping: true),
                                            priceListCart(
                                                context: context,
                                                title: 'Total',
                                                price: 'PKR: ${_totalPrice.toString()}',
                                                isTotal: true),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              );
                            }),
                        Container(
                          margin:
                          EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06,
                              bottom: MediaQuery.of(context).size.height * 0.03),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.13,
                          child: RaisedButton(
                            onPressed: () async {
                              bool isInfoNeeded = await getProfileInfo(user: _user, accountType: accountType);
                              print(isInfoNeeded);
                              if(isInfoNeeded){
                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text('Information Required!', style: TextStyle(fontFamily: 'Raleway'),),
                                    content: Text('Please fill out necessary information in Profile section before checkout',
                                      style: TextStyle(fontFamily: 'Raleway'),),
                                    actions: [
                                      FlatButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text('Okay', style: TextStyle(color: Colors.deepOrange, fontFamily: 'Nunito'),))
                                    ],
                                  );
                                });
                                return;
                              }
                              final profileSnapData = await FirebaseFirestore.instance.collection('Buyonic')
                                  .doc('Users').collection(accountType)
                                  .doc(_user.uid).get();

                              ProgressDialog dialog = new ProgressDialog(context);
                              dialog.style(
                                  message: 'Please wait...'
                              );

                              await dialog.show();
                              var response = await StripeService.payWithNewCard(
                                  amount: '${(_totalPrice*100).toString()}',
                                  currency: 'PKR'
                              );
                              await dialog.hide();
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response.message),
                                    duration: new Duration(milliseconds: response.success == true ? 1200 : 1200),
                                  )
                              );
                              int total= 0;

                                List<Map<String, dynamic>> productList = List();
                                int len = snapshotData.length;
                                if(response.success == true) {
                                  for (int i = 0; i < len; i++) {
                                    String category = snapshotData[i].get('Category');
                                    String prodId = snapshotData[i].get('ProdID');
                                    String productName = snapshotData[i].get('ProductName');
                                    int quantity = snapshotData[i].get('Quantity');
                                    String price = snapshotData[i].get('DiscountedPrice');
                                    String imageURL = snapshotData[i].get('ImageURL');
                                    int budget = (int.parse(price)) * quantity;
                                    total = total + budget;
                                    productList.add({
                                      'productName': productName,
                                      'Quantity': quantity,
                                      'Price': price,
                                      'ImageURL': imageURL
                                    }
                                    );

                                    await FirebaseFirestore.instance
                                        .collection('Admin')
                                        .doc('Data')
                                        .collection(category)
                                        .doc(prodId)
                                        .set({
                                      'AddToCart': {_user.uid: false}
                                    }, SetOptions(merge: true)).then((_) => {
                                      FirebaseFirestore.instance
                                          .collection('Cart')
                                          .doc('Data')
                                          .collection(_user.uid)
                                          .doc(snapshotData[i].id)
                                          .delete()
                                    });
                                  }

                                  String displayName;
                                  String userEmail;
                                  String email;
                                  print("KKK: ${_user.displayName}");
                                  if(_user.displayName!=null && _user.displayName!= ""){
                                    displayName = _user.displayName;
                                  }else{
                                    userEmail = _user.email;
                                  }
                                  if(userEmail != null) {
                                    String splittingEmail = userEmail.substring(0, userEmail.indexOf('@'));
                                    email = splittingEmail[0].toUpperCase() + splittingEmail.substring(1);
                                  }
                                  int totalPayment = total+200;
                                  final checkoutSnapshotData = await FirebaseFirestore.instance.collection
                                    ('Checkout').add({
                                    'ProductsInfo': productList,
                                    'TotalPayment': totalPayment,
                                    'User' : _user.uid,
                                    'Address': profileSnapData['Address'],
                                    'DisplayName': displayName == null ? email
                                        : displayName.substring(0, displayName.indexOf(' ')),
                                    'Phone': profileSnapData['Phone'],
                                    'Status': 'Pending',
                                    'DeliveryDate': '',
                                  });

                                  String docID = checkoutSnapshotData.id;
                                  print('DocID:  $docID');
                                  await FirebaseFirestore.instance.collection('Shipment')
                                      .doc('Data').collection(_user.uid)
                                      .add({
                                    'ProductsInfo': productList,
                                    'TotalPayment': totalPayment,
                                    'User' : _user.uid,
                                    'DisplayName': displayName == null ? email
                                        : displayName.substring(0, displayName.indexOf(' ')),
                                    'Address': profileSnapData['Address'],
                                    'Phone': profileSnapData['Phone'],
                                    'Status': 'Pending',
                                    'DeliveryDate': 'Pending',
                                  });
                                }

                              },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)]),
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child:  Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }),
    );
  }
}
