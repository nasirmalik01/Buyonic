import 'package:flutter/material.dart';

Widget imageCart({BuildContext context, String imageUrl}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.3,
      child: GridTile(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/placeholder.jpg'),
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

Widget priceCart({String title}) {
  return Text(
    title,
    style: TextStyle(
        fontFamily: 'Nunito',
        color: Color(0xFFFF5222),
        fontWeight: FontWeight.bold,
        fontSize: 15),
  );
}

Widget headingCart({String title, BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
    child: Text(
      title,
      style: TextStyle(
          fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 17),
    ),
  );
}

Widget subTotalWidget({String title, BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
    child: Text(
      title,
      style: TextStyle(
          fontFamily: 'Nunito',
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 15),
    ),
  );
}

Widget shippingText({String title}) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'RobotoCondensed-Italic',
      fontStyle: FontStyle.italic,
      fontSize: 16,
    ),
    textAlign: TextAlign.end,
  );
}

Widget quantityCart(
    {BuildContext context,
    String quantity,
    Function onAddTap,
    Function onSubTap}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onSubTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image(
                image: AssetImage(
                  'assets/images/remove.png',
                ),
              ),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.height * 0.035,
        child: Center(
          child: Text(
            quantity,
            style: TextStyle(
                fontFamily: 'Nunito', fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      GestureDetector(
        onTap: onAddTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image(
                image: AssetImage(
                  'assets/images/plus.png',
                ),
              ),
            )),
      ),
    ],
  );
}

Widget priceListCart({
  BuildContext context,
  String title,
  String price,
  bool isSubTotal = false,
  bool isShipping = false,
  bool isTotal = false,
}) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.07,
    width: MediaQuery.of(context).size.width * 0.9,
    child: Card(
      elevation: 3,
      color: Colors.white,
      shape: isSubTotal ? RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ) : isShipping ?  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(0),
        ),
      ):  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingCart(title: title, context: context),
          subTotalWidget(title: price, context: context)
        ],
      ),
    ),
  );
}
