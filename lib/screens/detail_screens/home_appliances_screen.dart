import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class HomeAppliancesScreen extends StatefulWidget {
  @override
  _HomeAppliancesScreenState createState() => _HomeAppliancesScreenState();
}

class _HomeAppliancesScreenState extends State<HomeAppliancesScreen> {
  bool _isSearching = false;
  String searchString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      !_isSearching ? Text('Home Appliances'): searchBarTextField(
          onChanged: (val){
            setState(() {
              searchString = val;
            });
          }
      ),
        actions: [
          IconButton(icon: Icon(_isSearching?Icons.cancel:
          Icons.search), onPressed: (){
            setState(() {
              if(_isSearching == true) searchString=null;
              _isSearching = !_isSearching;
            });
          })
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFFF4828), Color(0xFFFE8D03)])),
        ),),
      body:  detailBodyWidget(collection: 'appliances', searchString: searchString),
    );
  }
}
