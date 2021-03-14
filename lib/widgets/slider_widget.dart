import 'package:buyonic/widgets/slider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

Widget sliderWidget({BuildContext context}){
  MediaQueryData _mediaQuery = MediaQuery.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
    child: SizedBox(
      height: _mediaQuery.size.height * 0.2,
      width: double.infinity,
      child: Carousel(
        dotSize: 5,
        dotSpacing: 15,
        indicatorBgPadding: 10,
        dotBgColor: Colors.transparent,
        dotPosition: DotPosition.bottomCenter,
        images: [
          slider(
            context: context,
            bgImagePath: 'assets/images/gradient.jpg',
            assetImagePath: 'assets/images/laptop.png',
            title1: 'CLEARANCE',
            title2: 'SALE',
            subtitle1: 'Limited Stock, Lowest Price',
          ),
          slider(
            context: context,
            bgImagePath: 'assets/images/summer2.jpg',
            assetImagePath: 'assets/images/refr.png',
            title1: 'SUMMER IS',
            title2: 'HEATING UP',
            // subtitle1: 'Feel the summer breeze',
            subtitle1: 'Find the summer breeze',
            subtitle2: 'Upto 25% off',
            isSummer: true,
          ),slider(
              context: context,
              bgImagePath: 'assets/images/gaming.png',
              assetImagePath: 'assets/images/game.png',
              title1: 'GAMING',
              title2: 'SEASON',
              // subtitle1: 'Feel the summer breeze',
              subtitle1: 'Adding fun to life',
              isGaming: true,
              subtitle2: 'Upto 35% off'
          ),
        ],
      ),
    ),
  );
}