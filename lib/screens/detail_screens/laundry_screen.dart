import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class LaundryScreen extends StatefulWidget {
  @override
  _LaundryScreenState createState() => _LaundryScreenState();
}

class _LaundryScreenState extends State<LaundryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laundry and Household'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body:  detailBodyWidget(collection: 'laundry'),
    );
  }
}
