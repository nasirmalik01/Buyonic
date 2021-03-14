import 'package:buyonic/screens/detail_screens/laundry_screen.dart';
import 'package:buyonic/screens/detail_screens/mobile_screen.dart';
import 'package:buyonic/screens/detail_screens/skin_care_screen.dart';
import 'package:buyonic/screens/detail_screens/special_products_screens.dart';
import 'package:buyonic/widgets/products_display_widget.dart';
import 'package:buyonic/widgets/slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/detail_screens/popular_products_screens.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/detail_screens/laptops_screen.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/detail_screens/watches_screen.dart';
import 'file:///C:/Users/nasir/AndroidStudioProjects/buyonic/lib/screens/detail_screens/home_appliances_screen.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sliderWidget(context: context),
          rowTitleWidget(title: 'Special For You', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialProductsScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'special'),
          rowTitleWidget(title: 'Popular Deals', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PopularProductsScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'popular'),
          rowTitleWidget(title: 'Laptops', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LaptopScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'laptop'),
          rowTitleWidget(title: 'Mobiles',  onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'mobile'),
          rowTitleWidget(title: 'Watches', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WatchesScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'watches'),
          rowTitleWidget(title: 'Skin Care', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SkinCareScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'skin'),
          rowTitleWidget(title: 'Laundry And Household', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LaundryScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'laundry'),
          rowTitleWidget(title: 'Home Appliances',  onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAppliancesScreen()));
          }),
          productsDisplayWidget(context: context, collection: 'appliances'),

        ],
      ),
    );
  }
}
