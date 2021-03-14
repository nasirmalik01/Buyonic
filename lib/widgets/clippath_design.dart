import 'package:flutter/material.dart';

class ClipPathDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipPath(),
      child:  Container(
        height: MediaQuery.of(context).size.height*0.3,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFF4828),
                  Color(0xFFFE8D03),
                ]
            )
        ),
      ),
    );
  }
}

class MyClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 40);
    var firstEndPoint = Offset(size.width / 2, size.height);
    var firstControlPoint = Offset(80.0, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width-80 , size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
