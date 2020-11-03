
import 'package:flutter/material.dart';

class SliderModel {
  String title;
  String subtitle;
  String imagePath;
  Color color;

//  SliderModel({this.title, this.subtitle, this.imagePath});

  void setImagePath(String getImageAssetPath){
    imagePath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setsubTitle(String subTitle){
    subtitle = subTitle;
  }

  void setColor(Color getColor){
    color = getColor;
  }

  String get getTitle {
    return title;
  }

  String get getSubTitle {
    return subtitle;
  }

  String get getImagePath {
    return imagePath;
  }

  Color get getColor{
    return color;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> list = List<SliderModel>();
  SliderModel sliderModel = SliderModel();

  sliderModel.setTitle('WELCOME TO THE BUYONIC APP');
  sliderModel.setsubTitle('Where purchasing is easy and fun with ');
  sliderModel.setImagePath('assets/images/onboarding1.png');
  sliderModel.setColor(Colors.red);
  list.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.setTitle('JUST FOR YOU');
  sliderModel.setsubTitle('Everything you need, in the same platform. ');
  sliderModel.setImagePath('assets/images/smartphone.png');
  sliderModel.setColor(Colors.yellowAccent);
  list.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.setTitle('FRESH FRUITS AND VEGETABLES');
  sliderModel.setsubTitle('Serving Excellent, Fresh and Superior quality ');
  sliderModel.setImagePath('assets/images/healthyfood.png');
  list.add(sliderModel);
  sliderModel = SliderModel();



//  SliderModel sliderModel = SliderModel(
//      title: 'WELCOME TO THE BUYONIC APP 1',
//      subtitle:
//          'Where purchasing is easy and fun with ',
//      imagePath: 'assets/images/smartphone.png');
//  list.add(sliderModel);
//
//  SliderModel sliderModel2 = SliderModel(
//      title: 'WELCOME TO THE BUYONIC APP 2',
//      subtitle:
//          'Where purchasing is easy and fun with lot of products  to choose from!',
//      imagePath: 'assets/images/smartphone.png');
//  list.add(sliderModel2);
//
//  SliderModel sliderModel3 = SliderModel(
//      title: 'WELCOME TO THE BUYONIC APP 3',
//      subtitle:
//          'Where purchasing is easy and fun with lot of products  to choose from!',
//      imagePath: 'assets/images/smartphone.png');
//  list.add(sliderModel3);

  return list;
}
