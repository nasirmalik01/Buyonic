import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageDisplayScreen extends StatelessWidget {
  final String imageUrl;
  ImageDisplayScreen({this.imageUrl});

  final String noImageAvailable =
      "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272c35),
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Center(child: SpinKitFadingCircle(color: Colors.deepOrangeAccent,)),
            errorWidget: (context, url, error) =>
                Image.network(noImageAvailable, fit: BoxFit.cover),
          )
        ),
      ),
    );
  }
}
