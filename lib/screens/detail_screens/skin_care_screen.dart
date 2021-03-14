import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class SkinCareScreen extends StatefulWidget {
  @override
  _SkinCareScreenState createState() => _SkinCareScreenState();
}

class _SkinCareScreenState extends State<SkinCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skin Care'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body:  detailBodyWidget(collection: 'skin'),
    );
  }
}
