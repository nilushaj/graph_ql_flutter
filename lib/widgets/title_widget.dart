import 'package:flutter/material.dart';
import 'package:graph_ql_flutter/helper/constants/app_strings.dart';
import 'package:graph_ql_flutter/helper/utils.dart';

class TitleWidget extends StatelessWidget {
  TitleWidget({this.title, this.showViewAllButton=true, Key key})
      : super(key: key);
 
  final String title;
  final bool showViewAllButton;
  final _deviceHeight = Utils.totalBodyHeight;
  final _width = Utils.bodyWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical: _deviceHeight*10/812,horizontal: _width*16/345),
      child: Row(
        mainAxisAlignment: showViewAllButton?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Visibility(
            visible: showViewAllButton,
            child: Text(
              AppStrings.VIEW_ALL_TEXT,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
