import 'package:buyonic/main.dart';
import 'package:buyonic/screens/login_screen.dart';
import 'package:buyonic/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';
  FirebaseUser _user;
  String _isType;

  HomeScreen(this._user, this._isType);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  DocumentSnapshot _documentSnapshot;
  dynamic _photoURL;
  String _name;

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
    String _typeCheck;
    if (widget._isType == 'google') {
      print(widget._user.photoUrl);
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
    print(_photoURL);
    print(_name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: isLoading
                ? null
                : () {
                    _logout(context);
                  },
          ),
        ],
      ),
      drawer: Drawer(
          child: Container(
        child: Column(
          children: [
            widget._isType == 'google'
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(widget._user != null
                              ? widget._user.photoUrl
                              : CircularProgressIndicator(backgroundColor: Colors.white,)),
                        ),
                        Text(widget._user != null
                            ? widget._user.displayName
                            : ''),
                        Text(widget._user != null ? widget._user.uid : '')
                      ],
                    ),
                  )
                : widget._isType == 'email'
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget._user != null
                                ? widget._user.email
                                : 'No1'),
                            Text(widget._user != null ? widget._user.uid : 'No')
                          ],
                        ))
                    : widget._isType == 'facebook'
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection('Buyonic')
                                .document('Users')
                                .collection('Facebook')
                                .document(widget._user.uid)
                                .snapshots(),
                            builder: (context, snapshots) {
                              if (!snapshots.hasData) {
                                return CircularProgressIndicator();
                              }
                              print(snapshots.data['name']);
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.35,
                                color: Colors.grey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget._user != null
                                        ? widget._user.uid
                                        : ''),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(widget._user != null
                                          ? snapshots.data['profile_pic']
                                          : CircularProgressIndicator(backgroundColor: Colors.white,)),
                                    ),
                                    Text(snapshots.data['name'])
                                  ],
                                ),
                              );
                            })
                        : null,
          ],
        ),
      )),
      body: Center(
        child: Center(
          child: Text('Buyonic'),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.remove('type');
    await FirebaseAuth.instance.signOut();
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
