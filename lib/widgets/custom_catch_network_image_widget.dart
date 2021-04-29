import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';


import '../helper/utils.dart';

class CustomCacheNetworkImageWidget extends StatelessWidget {
  CustomCacheNetworkImageWidget({this.diameter, this.imageURL, Key key})
      : super(key: key);

  ///height
  final double diameter;

  ///logo url
  final String imageURL;

  @override
  Widget build(BuildContext context) => CircleAvatar(
    maxRadius: diameter/2,
    child: ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageURL ?? '',
        placeholder: (v, w) => Container(
          height: 20,
          width: 20,
          //using progress indiucator as placeholder for image view
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        fit: BoxFit.fill,
        errorWidget: (context, url, error) =>
            //show error icon when fail to load network image
            Icon(Icons.error),
      ),
    ),
  );
}
