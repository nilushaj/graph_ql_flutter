import 'package:flutter/material.dart';
import 'package:graph_ql_flutter/helper/constants/app_colors.dart';
import 'package:graph_ql_flutter/helper/utils.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({this.errorMessage,Key key}) : super(key: key);
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final _height = Utils.totalBodyHeight;
    final _width = Utils.bodyWidth;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: _height*20/812,horizontal: _width*16/345),
      child: Text('$errorMessage :(',textAlign: TextAlign.center,style: TextStyle(
        color: AppColors.ERROR_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
