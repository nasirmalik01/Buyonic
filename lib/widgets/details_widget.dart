import 'package:buyonic/widgets/Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget backIcon({BuildContext context, Widget iconButton}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        iconButton,
      ],
    ),
  );
}

Widget detailImageWidget({BuildContext context, String imageUrl, String tag, bool isVal = false}) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: GridTile(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 1, minHeight: 1), // here
              child:  isVal ? Hero(
                tag: tag,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/placeholder.jpg'),
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ): FadeInImage(
                placeholder: AssetImage('assets/images/placeholder.jpg'),
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget productInfoRow({String productName, String discountedPrice, BuildContext context}) {
  return Container(
    margin: EdgeInsets.only(top: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.6,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Text(
              productName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    discountedPrice,
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFFF5222),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:5),
                    width: double.infinity,
                    child: reviewText(title: 'No Reviews')),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget addToCartWidget(
    {BuildContext context,
    String counter,
    Function onTapAdd,
    Function onTapSub,
    Function onBtnPress,
      bool isLoading = false
    }) {
  return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5, bottom: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFF283148),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: quantityText(title: 'Quantity'),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.07,
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
                          counter.toString(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapAdd,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 4),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Color(0xFF535B6D),
                            border:
                                Border.all(width: 1, color: Color(0xFF535B6D))),
                        child: Image.asset('assets/images/plus.png'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapSub,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, top: 4),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.height * 0.07,
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
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading ? SpinKitFadingCircle(color: Colors.white,) : FlatButton.icon(
                      height: MediaQuery.of(context).size.height * 0.07,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Color(0xFFFF5959))),
                      minWidth: MediaQuery.of(context).size.width * 0.85,
                      color: Color(0xFFFF5959),
                      onPressed: onBtnPress,
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
                            fontSize: 17),
                      )),
                ),
              )
            ],
          ),
        ),
      ));
}
