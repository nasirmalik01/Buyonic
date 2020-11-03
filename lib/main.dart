import 'package:buyonic/screens/home_screen.dart';
import 'package:buyonic/screens/login_screen.dart';
import 'package:buyonic/screens/signup_screen.dart';
import 'package:buyonic/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}


FirebaseUser user;
String _type = '';

class _MyAppState extends State<MyApp> {
  bool isUser = false;



  Future<void> _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isLogin') != null){
      setState(() {
        isUser = prefs.getBool('isLogin');
        _type = prefs.getString('type');
      });
       user = await FirebaseAuth.instance.currentUser();
      print('isUser $isUser');
    }
  }


  @override
  void initState() {
    _initCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buyonic',
      home: WaitingScreen(isUser),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(user, _type)
      },
    );
  }
}


class WaitingScreen extends StatefulWidget {
  final bool isUser;

  WaitingScreen(this.isUser);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (c) => widget.isUser == true
                  ? HomeScreen(user, _type,)
                  : LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}


class ByonicApp extends StatefulWidget {
  @override
  _ByonicAppState createState() => _ByonicAppState();
}

class _ByonicAppState extends State<ByonicApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingScreen(),
    );
  }
}
