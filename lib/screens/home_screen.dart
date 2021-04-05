import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:buyonic/screens/cart_screen.dart';
import 'package:buyonic/screens/chat_screen.dart';
import 'package:buyonic/screens/detail_screens/special_products_screens.dart';
import 'package:buyonic/screens/shipment_screen.dart';
import 'package:buyonic/screens/wishlist_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/profile_screen.dart';
import 'package:buyonic/widgets/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:buyonic/methods.dart';

import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';
  final User _user;
  final String _isType;

  HomeScreen(this._user, this._isType);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int _currentIndex = 0;
  User currentUser;
  int val = 0;
  bool isInit = false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin localNotification;

  final tabs = [
    WelcomeScreen(),
    WishListScreen(),
    CartScreen(),
    ShipmentScreen()
    // ProfileScreen(),
  ];

  @override
  void initState() {
     currentUser =  FirebaseAuth.instance.currentUser;
    _configureFirebaseListeners();
    super.initState();
  }

  Future _showNotification(String body, String message) async {
    var androidDetails = AndroidNotificationDetails(
        "channelId", "Local Notification", 'Description here',
        importance: Importance.high);
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await localNotification.show(0, message == 'Order Confirmed' ?
    'Your order has been confirmed!'
        : message ==  'Special Product' ? 'Special Offer For You!'
        : 'Admin',
        message == 'Order Confirmed' ? 'Tap to check out details' :
        body, generalNotificationDetails);
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      var androidInitialize = AndroidInitializationSettings('ic_launcher');
      var iOSInitialize = IOSInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: androidInitialize, iOS: iOSInitialize);
      localNotification = FlutterLocalNotificationsPlugin();
      localNotification.initialize(initializationSettings,
           onSelectNotification:
           message['data']['message'] == 'Order Confirmed' ? onSelectShipmentNotification
          : message['data']['message'] == 'Special Product' ? onSelectNotification
          : null
      );
      String body = message['notification']['body'];
      _showNotification(body, message['data']['message']);
    },
        onResume: (Map<String, dynamic> message) async {
          if(message['data']['message'] == 'Order Confirmed'){
            setState(() {
              _currentIndex = 3;
            });
          }else if((message['data']['message'] == 'Special Product')) {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => SpecialProductsScreen()));
          }else{
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => ChattingScreen()));
          }
    },
        onLaunch: (Map<String, dynamic> message) async {
          if(message['data']['message'] == 'Order Confirmed'){

          }else if((message['data']['message'] == 'Special Product')){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => SpecialProductsScreen()));
          }else{
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => ChattingScreen()));
          }
    });
  }


  Future onSelectNotification(String payLoad) async{
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SpecialProductsScreen()));

  }

  Future onSelectChattingNotification(String payLoad) async{
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChattingScreen()));

  }

 Future onSelectShipmentNotification(String payLoad) async{
    setState(() {
      _currentIndex = 3;
    });

  }

  @override
  Future<void> didChangeDependencies() async {
    print('didChangeDependencies() called');
    isInit = true;
    if (isInit) {
      // QuerySnapshot querySnapshot =
      //     await FirebaseFirestore.instance.collection('DeviceTokens').get();
      // _firebaseMessaging.getToken().then((deviceToken) async => {
      //       if (querySnapshot.docs.length == 0)
      //         {
      //           await FirebaseFirestore.instance
      //               .collection('DeviceTokens')
      //               .add({
      //             'device_token': deviceToken,
      //           }),
      //         },
      //       for (int i = 0; i < querySnapshot.docs.length; i++)
      //         {
      //           if (deviceToken
      //               .contains(querySnapshot.docs[i].get('device_token')))
      //             {val = val + 1}
      //         },
      //       print('---- ${querySnapshot.docs.length}'),
      //       if (querySnapshot.docs.length > 0)
      //         {
      //           if (val == 0)
      //             {
      //               await FirebaseFirestore.instance
      //                   .collection('DeviceTokens')
      //                   .add({
      //                 'device_token': deviceToken,
      //               }),
      //             }
      //         }
      //     });
      _firebaseMessaging.getToken().then((deviceToken) async => {
                await FirebaseFirestore.instance
                    .collection('DeviceTokens').doc(currentUser.uid)
                    .set({
                  'device_token': deviceToken,
                }, SetOptions(merge: true)),

        print("UID: $deviceToken")

      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? ' Welcome'
              : _currentIndex == 1
                  ? ' My Wishlist'
                  : _currentIndex == 2
                      ? 'Cart'
                      : 'Shipments',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.exit_to_app),
          //   onPressed: isLoading
          //       ? null
          //       : () {
          //           _logout(context);
          //         },
          // ),
          // IconButton(
          //   icon: Icon(Icons.exit_to_app),
          //   onPressed: isLoading
          //       ? null
          //       : () {
          //     _logout(context);
          //   },
          // ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: _currentIndex == 3 ? IconButton(
                icon: Icon(Icons.message, color: Colors.black,),
                onPressed: (){
                  onMessageTap(context: context);
                },
              ) : widget._isType != 'Email'
                  ? CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        widget._user != null
                            ? widget._user.photoURL
                            : CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                      ),
                    )
                  : Icon(
                      Icons.account_circle,
                      color: Colors.deepOrange,
                      size: 45,
                    ),
            ),
          ),
        ],
      ),
      // drawer: Drawer(
      //     child: Container(
      //   child: Column(
      //     children: [
      //       widget._isType == 'google'
      //           ? Container(
      //               width: MediaQuery.of(context).size.width,
      //               height: MediaQuery.of(context).size.height * 0.35,
      //               color: Colors.grey,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   CircleAvatar(
      //                     radius: 50,
      //                     backgroundImage: NetworkImage(widget._user != null
      //                         ? widget._user.photoUrl
      //                         : CircularProgressIndicator(backgroundColor: Colors.white,)),
      //                   ),
      //                   Text(widget._user != null
      //                       ? widget._user.displayName
      //                       : ''),
      //                   Text(widget._user != null ? widget._user.uid : '')
      //                 ],
      //               ),
      //             )
      //           : widget._isType == 'email'
      //               ? Container(
      //                   width: MediaQuery.of(context).size.width,
      //                   height: MediaQuery.of(context).size.height * 0.35,
      //                   color: Colors.grey,
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Text(widget._user != null
      //                           ? widget._user.email
      //                           : 'No1'),
      //                       Text(widget._user != null ? widget._user.uid : 'No')
      //                     ],
      //                   ))
      //               : widget._isType == 'facebook'
      //                   ? StreamBuilder(
      //                       stream: Firestore.instance
      //                           .collection('Buyonic')
      //                           .document('Users')
      //                           .collection('Facebook')
      //                           .document(widget._user.uid)
      //                           .snapshots(),
      //                       builder: (context, snapshots) {
      //                         if (!snapshots.hasData) {
      //                           return CircularProgressIndicator();
      //                         }
      //                         print(snapshots.data['name']);
      //                         return Container(
      //                           width: MediaQuery.of(context).size.width,
      //                           height: MediaQuery.of(context).size.height * 0.35,
      //                           color: Colors.grey,
      //                           child: Column(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Text(widget._user != null
      //                                   ? widget._user.uid
      //                                   : ''),
      //                               CircleAvatar(
      //                                 radius: 50,
      //                                 backgroundImage: NetworkImage(widget._user != null
      //                                     ? snapshots.data['profile_pic']
      //                                     : CircularProgressIndicator(backgroundColor: Colors.white,)),
      //                               ),
      //                               Text(snapshots.data['name'])
      //                             ],
      //                           ),
      //                         );
      //                       })
      //                   : null,
      //     ],
      //   ),
      // )),
      body: tabs[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: BubbleBottomBar(
          backgroundColor: Colors.white,
          opacity: 1,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(Icons.home, color: Colors.white),
              title: Text("Home", style: bottomBarItemStyle),
            ),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                activeIcon: Icon(Icons.favorite_border, color: Colors.white),
                title: Text("Wishlist", style: bottomBarItemStyle)),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.black,
                ),
                activeIcon: Icon(Icons.add_shopping_cart, color: Colors.white),
                title: Text("Shop", style: bottomBarItemStyle)),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.local_shipping_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(Icons.local_shipping_outlined, color: Colors.white),
                title: Text("Shipment", style: bottomBarItemStyle)),
            // BubbleBottomBarItem(
            //     backgroundColor: Colors.black,
            //     icon: Icon(
            //       Icons.person,
            //       color: Colors.black,
            //     ),
            //     activeIcon: Icon(Icons.person, color: Colors.white),
            //     title: Text("Profile", style: bottomBarItemStyle))
          ],
        ),
      ),
    );
  }

// Future<void> _logout(BuildContext context) async {
//   setState(() {
//     isLoading = true;
//   });
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('isLogin');
//   await prefs.remove('type');
//   await FirebaseAuth.instance.signOut();
//   setState(() {
//     isLoading = false;
//   });
//   Navigator.pushReplacementNamed(context, LoginScreen.routeName);
// }
}
