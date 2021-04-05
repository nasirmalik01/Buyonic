import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';


class SpecialProductsScreen extends StatefulWidget {
  @override
  _SpecialProductsScreenState createState() => _SpecialProductsScreenState();
}

class _SpecialProductsScreenState extends State<SpecialProductsScreen> {
  bool _isSearching = false;
  String searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      !_isSearching ? Text('Special For You') : searchBarTextField(
          onChanged: (String val){
            setState(() {
              searchString = val.toLowerCase();
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
      body: detailBodyWidget(collection: 'special', searchString: searchString),
    );
  }
}
