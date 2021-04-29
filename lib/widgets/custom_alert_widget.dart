// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:graph_ql_flutter/helper/constants/app_strings.dart';


class CustomAlertBox extends StatelessWidget {

  const CustomAlertBox({ this.message, Key key})
      : super(key: key);


  ///message
  final String message;



  @override
  Widget build(BuildContext context) => PlatformAlertDialog(
    title: Text(AppStrings.ALERT_BOX_TITLE),
    content: Text(message),
    actions: [
      PlatformDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: PlatformText('Close'),
      ),
    ],
  );
}