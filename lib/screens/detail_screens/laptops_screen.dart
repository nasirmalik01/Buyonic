import 'package:buyonic/widgets/Widget.dart';
import 'package:buyonic/widgets/detail_screen_body.dart';
import 'package:flutter/material.dart';

class LaptopScreen extends StatefulWidget {
  @override
  _LaptopScreenState createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  bool _isSearching = false;
  String searchString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      !_isSearching ? Text('Laptops'): searchBarTextField(
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
      body:  detailBodyWidget(collection: 'laptop', searchString: searchString),
    );
  }
}
