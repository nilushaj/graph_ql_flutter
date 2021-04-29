//This class holds all the static util methods that is used within the app//

// Flutter imports:
import 'package:flutter/material.dart';

///Utils class
class Utils {
  //Call these variables to get initialized screen sizes//

  ///app bar height
  static final double appBarHeight = AppBar().preferredSize.height;

  ///status bar height
  static double statusBarHeight;

  ///total screen height without appbar or status bar
  static double totalBodyHeight;

  ///body height with appbar and status bar reduced
  static double reducedBodyHeight;

  ///body height with status bar reduced
  static double contentBodyHeight;

  ///total screen width
  static double bodyWidth;

  ///Set screen sizes
  static setScreenSizes(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    bodyWidth = MediaQuery.of(context).size.width;
    totalBodyHeight = MediaQuery.of(context).size.height;

    reducedBodyHeight = totalBodyHeight - appBarHeight - statusBarHeight;
    contentBodyHeight = reducedBodyHeight - statusBarHeight;
  }
}
