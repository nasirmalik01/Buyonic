import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:buyonic/screens/wishlist_screen.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/profile_screen.dart';
import 'package:buyonic/widgets/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // DocumentSnapshot _documentSnapshot;
  // dynamic _photoURL;
  // String _name;
  int _currentIndex = 0;

  final tabs = [
    WelcomeScreen(),
    Center(
      child: Text('Cart'),
    ),
    WishListScreen(),
    // ProfileScreen(),
  ];

  // final String email = 'email';
  // final String google = 'google';
  // final String facebook = 'facebook';

  // Future<void> _getFbData() async {
  //   _documentSnapshot = await Firestore.instance
  //       .collection('Buyonic')
  //       .document('Users')
  //       .collection('Facebook')
  //       .document(widget._user.uid)
  //       .get();
  //   if (_documentSnapshot.data != null) {
  //     _photoURL = _documentSnapshot.data['profile_pic'];
  //     _name = _documentSnapshot.data['name'];
  //     print(_photoURL);
  //     print(_name);
  //   }
  // }

  @override
  void didChangeDependencies() {
    if (widget._isType == 'google') {
      print(widget._user.photoURL);
      print('google');
    } else if (widget._isType == 'email') {
      print('email');
    } else if (widget._isType == 'facebook') {
      print('facebook');
    }
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
          _currentIndex == 0 ? ' Welcome'
              : _currentIndex == 1 ? ' Cart'
              : _currentIndex == 2 ? ' My Wishlist'
              : 'Profile',
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
              onTap: (){
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: widget._isType != 'email'? CircleAvatar(
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
                  Icons.add_shopping_cart,
                  color: Colors.black,
                ),
                activeIcon: Icon(Icons.add_shopping_cart, color: Colors.white),
                title: Text("Shop", style: bottomBarItemStyle)),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                activeIcon: Icon(Icons.favorite_border, color: Colors.white),
                title: Text("Wishlist", style: bottomBarItemStyle)),
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
