import 'package:buyonic/data/onboarding_data.dart';
import 'package:buyonic/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  List<SliderModel> mySLides = List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == slideIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey[600],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }



  @override
  void initState() {
    mySLides = getSlides();
    controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: slideIndex == 0
                  ? [Color(0XFFB101BC), Color(0xFF372378)]
                  : slideIndex == 1
                  ? [Color(0xFF2980b9), Color(0xFF2c3e50)]
                  : [Color(0xFF5B51C2), Color(0xFF240956)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1])),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height * 0.2,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                            MediaQuery.of(context).size.height * 0.06),
                        child: Image(
                          image: AssetImage(mySLides[0].getImagePath),
                          height: 170,
                          width: 170,
                        ),
                      ),
                      Text(
                        mySLides[0].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            fontFamily: 'RobotoCondensed'),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.height * 0.05,
                            right: MediaQuery.of(context).size.height * 0.05),
                        child: RichText(
                          text: TextSpan(
                            text: mySLides[0].getSubTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                            ),
                            children: [
                              TextSpan(
                                  text: 'lot of products',
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 18,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: ' to choose from!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Nunito',
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                            MediaQuery.of(context).size.height * 0.06),
                        child: Image(
                          image: AssetImage(mySLides[1].getImagePath),
                          height: 170,
                          width: 170,
                        ),
                      ),
                      Text(
                        mySLides[1].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            fontFamily: 'RobotoCondensed'),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.height * 0.04,
                            right: MediaQuery.of(context).size.height * 0.04),
                        child: RichText(
                          text: TextSpan(
                            text: mySLides[1].getSubTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                            ),
                            children: [
                              TextSpan(
                                  text: 'Get started today ',
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 18,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: 'with us!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Nunito',
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom:
                            MediaQuery.of(context).size.height * 0.06),
                        child: Image(
                          image: AssetImage(mySLides[2].getImagePath),
                          height: 160,
                          width: 160,
                        ),
                      ),
                      Text(
                        mySLides[2].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            fontFamily: 'RobotoCondensed'),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.height * 0.07,
                            right: MediaQuery.of(context).size.height * 0.07),
                        child: RichText(
                          text: TextSpan(
                            text: mySLides[2].getSubTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Nunito',
                            ),
                            children: [
                              TextSpan(
                                  text: 'Fruits and Vegetables',
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 18,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Nunito',
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          slideIndex != 2
              ? Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: FlatButton(
                onPressed: () {
                  controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontFamily: 'Raleway'),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          )
              : Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.height * 0.03,
                right: MediaQuery.of(context).size.height * 0.03),
            decoration:
            BoxDecoration(border: Border.all(color: Colors.white)),
            child: Align(
              alignment: FractionalOffset.center,
              child: FlatButton(
                onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Get Started Now',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontFamily: 'Raleway'),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
