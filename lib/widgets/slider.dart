import 'package:flutter/material.dart';

Widget slider({BuildContext context,
  String assetImagePath,
  String bgImagePath,
  String title1,
  String title2,
  String subtitle1,
  String subtitle2,
  bool isSummer = false,
  bool isGaming = false
}) {
  final _mediaQuery = MediaQuery.of(context);
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFFEC2560),
        //     Color(0xFFE63BAD),
        //   ],
        // ),
        image: DecorationImage(
            image: AssetImage(bgImagePath),
            fit: BoxFit.cover
        )
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: TextStyle(
                  color: isSummer ? Color(0xFF622B8E) :Colors.white,
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Container(
              margin: EdgeInsets.only(

              ),
              child: Text(
                title2,
                style: TextStyle(
                    color: isSummer ? Color(0xFF622B8E) :Colors.white,
                    fontFamily: 'Lobster',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _mediaQuery.size.height * 0.02,
              ),
              child: Text(
                subtitle1,
                style: TextStyle(
                    color: isSummer ? Colors.black : Colors.amber,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            if(isGaming || isSummer)
            Text(
              subtitle2,
              style: TextStyle(
                  color: isSummer ? Colors.black : Colors.amber,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
        Image(
          image: AssetImage(assetImagePath),
          height: 100,
          width: 100,
        ),
      ],
    ),
  );
}
