import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bluestack/pages/home/homescreen.dart';
import 'package:flutter_app_bluestack/utils/AppColors.dart';

import 'navdrawer.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: IconThemeData(color: AppColors.kBlack),

          title: Text(
            'Flyingwolf',
            style: TextStyle(color: AppColors.kBlack),
          ),
          centerTitle: true,
        ),
        body: MyHomeScreen());
  }
}
