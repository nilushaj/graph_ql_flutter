import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../helper/constants/app_colors.dart';
import '../helper/utils.dart';
import '../models/RepoData.dart';
import 'custom_alert_widget.dart';
import 'custom_catch_network_image_widget.dart';

class RepoDetailsWidget extends StatelessWidget {
  RepoDetailsWidget({this.repoData, this.width, this.height, Key key})
      : super(key: key);

  final RepoData repoData;

  final double height;
  final double width;

  final double _height = Utils.totalBodyHeight;
  final double _width = Utils.bodyWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPostPermissionAlertDialog(
          mContext: context, name: repoData.name),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.BACKGROUND_COLOR,
            border: Border.all(color: AppColors.BORDER_COLOR)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _height * 10 / 812, horizontal: _width * 16 / 345),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCacheNetworkImageWidget(
                    diameter: 40,
                    imageURL: repoData.imageUrl ?? '',
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: _width * 16 / 345),
                      child: Text(
                        '${repoData.name ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: _height * 16 / 812),
                child: Text(
                  '${repoData.repoDescription ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: _width * 10 / 345),
                    child: CircleAvatar(
                      maxRadius: 5,
                      backgroundColor: AppColors.FORK_COLOR,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _width * 30 / 345),
                    child: Text(
                      '${repoData.forkCount}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _width * 10 / 345),
                    child: CircleAvatar(
                      maxRadius: 5,
                      backgroundColor: AppColors.LANGUAGE_COLOR,
                    ),
                  ),
                  Text(
                    '${repoData.language}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showPostPermissionAlertDialog({BuildContext mContext, String name}) async {
    // show the dialog
    await showPlatformDialog(
      context: mContext,
      builder: (BuildContext context) => CustomAlertBox(
        message: name,
      ),
    );
  }
}
