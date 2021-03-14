import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class HomeAppliancesScreen extends StatefulWidget {
  @override
  _HomeAppliancesScreenState createState() => _HomeAppliancesScreenState();
}

class _HomeAppliancesScreenState extends State<HomeAppliancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Appliances'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body:  detailBodyWidget(collection: 'appliances'),
    );
  }
}
