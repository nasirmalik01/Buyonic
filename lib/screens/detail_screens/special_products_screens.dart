import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';


class SpecialProductsScreen extends StatefulWidget {
  @override
  _SpecialProductsScreenState createState() => _SpecialProductsScreenState();
}

class _SpecialProductsScreenState extends State<SpecialProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Special For You'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body: detailBodyWidget(collection: 'special'),
    );
  }
}
