import 'package:buyonic/screens/home_screen.dart';
import 'package:buyonic/screens/signup_screen.dart';
import 'package:buyonic/widgets/Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Map<String, String> authValues = {'email': '', 'password': ''};
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final facebookLogin = FacebookLogin();
  bool obscureText =  true;

  // final String email = 'email';
  // final String google = 'google';
  // final String facebook = 'facebook';

  Widget textValues(
      {String text,
      String fontFamily,
      FontWeight fontWeight,
      Color color,
      double fontSize}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: fontFamily ?? 'Nunito',
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 30,
          color: color ?? Colors.black),
    );
  }

  void snackbarError({String errorMessage}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: Colors.white70, // status bar color
//    ));
    FocusScopeNode currentFocus = FocusScope.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: mediaQuery.size.height * 0.35,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: constraints.maxHeight * 0.3),
                          child: Center(
                            child: textValues(
                                text: 'Buyonic',
                                color: Color(0xFF1E319D),
                                fontSize: 45,
                                fontFamily: 'Lobster-Regular'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.2,
                              left: constraints.maxWidth * 0.08),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: textValues(
                                text: 'LogIn to Your Account',
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: mediaQuery.size.height * 0.65,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.76,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Card(
                                      elevation: 4,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle:
                                              TextStyle(fontFamily: 'Raleway'),
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Email can\'t be empty';
                                          }
                                          if (!RegExp(
                                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                            return 'Please enter a valid email Address';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          authValues['email'] = value;
                                        },
                                        style: TextStyle(fontFamily: 'Raleway'),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Card(
                                      elevation: 4,
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: obscureText,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle:
                                              TextStyle(fontFamily: 'Raleway'),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              !obscureText ? Icons.visibility : Icons.visibility_off
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                          ),
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Password can\'t be empty';
                                          } else if (value.length < 5) {
                                            return 'Password must be greater than 5 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          authValues['password'] = value;
                                        },
                                        style: TextStyle(fontFamily: 'Raleway'),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF1488cc),
                                            Color(0xFF2b32b2),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.circular(25)),
                                  margin: EdgeInsets.only(
                                      top: constraints.maxHeight * 0.05),
                                  width: constraints.maxWidth * 0.9,
                                  child: FlatButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(20.0),
//                  ),
                                    // color: Color(0xFF1E319D),
                                    onPressed: () {
                                      currentFocus.unfocus();
                                      _submitForm();
                                    },
                                    child: isLoading
                                        ? Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SpinKitFadingCircle(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: textValues(
                                                text: 'Sign In',
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Raleway',
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      textValues(
                                          text: 'Don\'t have an account ?  ',
                                          fontSize: 15,
                                          fontFamily: 'Raleway',
                                          color: Colors.grey),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  SignupScreen.routeName);
                                        },
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.pink,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          Container(
                            height: constraints.maxHeight * 0.23,
                            child: Column(
                              children: <Widget>[
                                textValues(
                                  text: '- Or sign In with -',
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Raleway',
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                SizedBox(height: constraints.maxHeight * 0.04),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    socialMediaButton(
                                      text: 'Google',
                                      imageURL: 'assets/images/google.png',
                                      color: Color(0xFFDD4337),
                                      context: context,
                                      onPress: _googleSignIn,
                                    ),
                                    socialMediaButton(
                                      text: 'Facebook',
                                      imageURL: 'assets/images/facebook.png',
                                      color: Color(0xFF3B5999),
                                      context: context,
                                      onPress: _loginWithFB,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _googleSignIn() async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Signing in'),
    ));
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googlSignIn = new GoogleSignIn();
    try {
      final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User _userDetails =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Buyonic')
          .doc('Users')
          .collection('Google')
          .doc(_userDetails.uid)
          .get();

      if (documentSnapshot.data() == null) {
        await FirebaseFirestore.instance
            .collection('Buyonic')
            .doc('Users')
            .collection('Google')
            .doc(_userDetails.uid)
            .set({
          'name': _userDetails.displayName,
          'profile_pic': _userDetails.photoURL,
          'email': _userDetails.email,
          'type' : 'Google',
          'Address': 'Not set',
          'DOB': 'Not set',
          'Phone': 'Not set'
        });
      }

      print(_userDetails.email);
      print(_userDetails.displayName);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setString('type', 'Google');

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(_userDetails, prefs.getString('type'))));

      print('Signed in with google');
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Could not Authenticate. Try Again Later'),
      ));
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();
    print('Signin ${authValues['email']} ${authValues['password']}');
    try {
      final newUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authValues['email'], password: authValues['password']);

      if (newUser != null) {
        User _user =  FirebaseAuth.instance.currentUser;
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('Buyonic')
            .doc('Users')
            .collection('Email')
            .doc(_user.uid)
            .get();

        if (documentSnapshot.data() == null) {
          await FirebaseFirestore.instance
              .collection('Buyonic')
              .doc('Users')
              .collection('Email')
              .doc(_user.uid)
              .set({
            'email': _user.email,
            'type' : 'Email',
            'Address': 'Not set',
            'DOB': 'Not set',
            'Phone': 'Not set',
            'profile_pic' : 'http://med.gov.bz/wp-content/uploads/2020/08/dummy-profile-pic.jpg',
          });
        }

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('type', 'Email');

        print('isLogin : ${prefs.getBool('isLogin')}');
        setState(() {
          isLoading = false;
        });
        //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(_user, prefs.getString('type')),
            ));
      }
    } catch (e) {
      print('Error $e');
      setState(() {
        isLoading = false;
      });

      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        snackbarError(errorMessage: 'This Email is not Registered');
      }
      if (e.message ==
          'The password is invalid or the user does not have a password.') {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        snackbarError(
            errorMessage: 'You have entered wrong password. Try Again!');
      }
      if (e.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        snackbarError(errorMessage: 'Connection Timeout. Try Again');
      }

      if (e.message == 'The email address is badly formatted.') {
        _scaffoldKey.currentState.hideCurrentSnackBar();
        snackbarError(errorMessage: 'Email Address is bady formatted');
      }
      return;
    }
  }

  _loginWithFB() async {
    setState(() {
      isLoading = true;
    });
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final AuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken.token,
        );
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        final User _user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        if(_user != null){
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('Buyonic')
              .doc('Users')
              .collection('Facebook')
              .doc(_user.uid)
              .get();

          if (documentSnapshot.data() == null) {
            await FirebaseFirestore.instance
                .collection('Buyonic')
                .doc('Users')
                .collection('Facebook')
                .doc(_user.uid)
                .set({
              'name' : profile['name'],
              'email' : profile['email'],
              'profile_pic' : profile['picture']['data']['url'],
              'type' : 'Facebook',
              'Address': 'Not set',
              'DOB': 'Not set',
              'Phone': 'Not set'
            });
          }
        }
        print('Fb Logged In');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('type', 'Facebook');

        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                _user,
                prefs.getString('type'),
              ),
            ));
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() {
          isLoading = false;
        });
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoading = false);
        _scaffoldKey.currentState.hideCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('There is some Error. Try Again'),
        ));
        break;
    }
  }
}
