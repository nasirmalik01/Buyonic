import 'package:flutter/cupertino.dart';

class Favorite extends ChangeNotifier{
  bool isFav;

  Favorite({this.isFav = false});

  void toggleFavoriteStatus(){
    isFav = !isFav;
    notifyListeners();
  }
}

