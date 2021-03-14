import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class WatchesScreen extends StatefulWidget {
  @override
  _WatchesScreenState createState() => _WatchesScreenState();
}

class _WatchesScreenState extends State<WatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watches'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body:  detailBodyWidget(collection: 'watches'),
    );
  }
}
