import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buyonic/screens/home_screen.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/profile_screen.dart';
import 'package:buyonic/screens/login_screen.dart';
import 'package:buyonic/screens/signup_screen.dart';
import 'package:buyonic/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buyonic/providers/favorite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

User user;
String _type = '';

class _MyAppState extends State<MyApp> {
  bool isUser = false;

  Future<void> _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogin') != null) {
      setState(() {
        isUser = prefs.getBool('isLogin');
        _type = prefs.getString('type');
      });
      user =  FirebaseAuth.instance.currentUser;
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
    return ChangeNotifierProvider.value(
      value: Favorite(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buyonic',
        home: WaitingScreen(isUser),
        routes: {
          SignupScreen.routeName: (context) => SignupScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(user, _type),
          ProfileScreen.routeName: (context) => ProfileScreen()
        },
      ),
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
                  ? HomeScreen(
                      user,
                      _type,
                    )
                  : OnboardingScreen()));
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
