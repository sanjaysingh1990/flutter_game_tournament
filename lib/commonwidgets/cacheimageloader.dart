import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CacheImageLoader extends StatelessWidget {
  final String url;
  final BoxFit boxFit;

  CacheImageLoader({@required this.url, this.boxFit});

  @override
  Widget build(BuildContext context) {
    print("icon url $url");
    return new CachedNetworkImage(
      width: double.infinity,
      height: double.infinity,
      imageUrl: url ?? "",
      matchTextDirection: true,
      fit: boxFit,
      placeholder: (context, String val) {
        return Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: new Center(
            child: new CupertinoActivityIndicator(),
          ),
        );
      },
      errorWidget: (BuildContext context, String error, Object obj) {
        return new Center(
            child: Icon(
          Icons.image,
          color: Colors.grey,
          size: 36.0,
        ));
      },
    );
  }
}
