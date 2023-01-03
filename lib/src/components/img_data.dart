import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width;

  ImageData(
    this.icon, {
    Key? key,
    this.width = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: width! / Get.mediaQuery.devicePixelRatio);
  }
}

class IconsPath {
  static String get homeOff => 'assets/img/bottom_nav_home_off_icon.jpg';
  static String get homeOn => 'assets/img/bottom_nav_home_on_icon.jpg';
  static String get searchOff => 'assets/img/bottom_nav_search_off_icon.jpg';
  static String get searchOn => 'assets/img/bottom_nav_search_on_icon.jpg';
  static String get uploadIcon => 'assets/img/bottom_nav_upload_icon.jpg';
  static String get activeOff => 'assets/img/bottom_nav_active_off_icon.jpg';
  static String get activeOn => 'assets/img/bottom_nav_active_on_icon.jpg';
}
