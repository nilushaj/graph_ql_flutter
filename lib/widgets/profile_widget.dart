import 'package:flutter/material.dart';
import 'package:graph_ql_flutter/models/profile_data.dart';
import '../helper/utils.dart';

import 'custom_catch_network_image_widget.dart';

class ProfileDetailsWidget extends StatelessWidget {

  ProfileDetailsWidget({this.profileData,Key key}) : super(key: key);

  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    final _height = Utils.totalBodyHeight;
    final _width = Utils.bodyWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCacheNetworkImageWidget(
              diameter: 60,
              imageURL: profileData.imageURL??'',
            ),
            Padding(
              padding: EdgeInsets.only(left: _width*16/345),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${profileData.fullName}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Text('${profileData.userName}',style: TextStyle(fontSize: 12,),)
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: _height*16/812),
          child:  Text('${profileData.email}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: _width*30/345),
              child: Text('${profileData.noOfFollowers} followers',style: TextStyle(fontSize: 12),),
            ),
            Text('${profileData.noOfFollowing} following',style: TextStyle(fontSize: 12,),),
          ],
        )
      ],
    );
  }
}
