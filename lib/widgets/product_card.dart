import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget productCard(
    {BuildContext context,
    String imageURL,
    String productName,
    String orignalPrice,
    String discountedPrice,
      Function onTap,
      Function onFavPress,
      bool isFav = false
    }) {
  MediaQueryData _mediaQuery = MediaQuery.of(context);
  return Stack(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              width: _mediaQuery.size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: GridTile(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 1, minHeight: 1), // here
                          child: FadeInImage(
                            placeholder: AssetImage('assets/images/placeholder.jpg'),
                            image: NetworkImage(imageURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.03),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        productName,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

            Container(
              margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
              child: RichText(
                text:  TextSpan(
                  children: <TextSpan>[
                     TextSpan(text:
                  'PKR: $discountedPrice  ',
                  style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 16,
                      color: Color(0xFFFF5222),
                      fontWeight: FontWeight.bold),
                ),
                     TextSpan(text: orignalPrice, style:  TextStyle(
                        fontFamily: 'Lobster',
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2
                    ),),
                  ],
                ),
              ),
            ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 5,
        right: 5,
        child: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.red,
                ),
                onPressed: onFavPress),
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'No reviews',
            style: TextStyle(
              fontFamily: 'Nunito',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}


Widget productCard2(
    {BuildContext context,
      String imageURL,
      String productName,
      String orignalPrice,
      String discountedPrice,
      Function onTap,
      Function onFavPress,
      bool isFav = false,
      String tag
    }) {
  MediaQueryData _mediaQuery = MediaQuery.of(context);
  return Stack(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              width: _mediaQuery.size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: GridTile(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 1, minHeight: 1), // here
                          child: Hero(
                            tag: tag,
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/placeholder.jpg'),
                              image: NetworkImage(imageURL),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.03),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        productName,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                    child: RichText(
                      text:  TextSpan(
                        children: <TextSpan>[
                          TextSpan(text:
                          'PKR: $discountedPrice  ',
                            style: TextStyle(
                                fontFamily: 'Lobster',
                                fontSize: 16,
                                color: Color(0xFFFF5222),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: orignalPrice, style:  TextStyle(
                              fontFamily: 'Lobster',
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2
                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 5,
        right: 5,
        child: IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_outline,
              color: Colors.red,
            ),
            onPressed: onFavPress),
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'No reviews',
            style: TextStyle(
              fontFamily: 'Nunito',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

