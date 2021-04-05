import 'package:flutter/material.dart';

Widget imageWishList({BuildContext context, String imageUrl}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
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

Widget quantityProduct({BuildContext context, String counterValue, Function onAddTap, Function onSubTap}) {
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              border: Border.all(
                width: 1,
                color: Color(0xFF535B6D),
              )),
          child: Center(
            child: Text(
              counterValue,
              style: TextStyle(
                  fontFamily: 'Nunito', fontSize: 15, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                color: Color(0xFF535B6D),
                border: Border.all(width: 1, color: Color(0xFF535B6D))),
            child: Image.asset('assets/images/plus.png'),
          ),
        ),
        GestureDetector(
          onTap: onSubTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                color: Color(0xFF535B6D),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: Color(0xFF535B6D),
                )),
            child: Image.asset('assets/images/remove.png'),
          ),
        ),
      ],
    ),
  );
}

Widget addToCart({BuildContext context, Function onPress}){
  return  Container(
    alignment: Alignment.bottomRight,
    child: FlatButton.icon(
        height:
        MediaQuery.of(context).size.height * 0.04,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Color(0xFFFF5959))),
        minWidth:
        MediaQuery.of(context).size.width * 0.4,
        color: Color(0xFFFF5959),
        onPressed: onPress,
        icon: Icon(
          Icons.add_shopping_cart_outlined,
          color: Colors.white,
        ),
        label: Text(
          'Add to Cart',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12),
        )),
  );
}
