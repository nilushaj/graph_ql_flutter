import 'package:flutter/material.dart';
import 'package:graph_ql_flutter/helper/constants/app_colors.dart';

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ///Circular progress indicator to show until data is retrieved
      Center(
        child: Container(
          margin: EdgeInsets.all(10),
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            backgroundColor: AppColors.PRIMARY_COLOR,
          ),
        ),
      );
  }
}
