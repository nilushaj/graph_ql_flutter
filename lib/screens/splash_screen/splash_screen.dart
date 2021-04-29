import 'dart:async';

import 'package:flutter/material.dart';

import '../../helper/constants/app_colors.dart';
import '../../helper/constants/app_strings.dart';
import '../../helper/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, AppStrings.PROFILE_ROUTE);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //Set the screen sizes and the static util variables
    Utils.setScreenSizes(context);

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SafeArea(
          child: Center(
            child: Text(
              AppStrings.SPLASH_SCREEN_TITLE,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.PRIMARY_COLOR),
            ),
          ),
        ),
      ),
    );
  }
}
