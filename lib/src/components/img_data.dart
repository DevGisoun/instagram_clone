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
  static String get logo => 'assets/img/logo.jpg';
  static String get directMessage => 'assets/img/direct_msg_icon.jpg';
  static String get plusIcon => 'assets/img/plus_icon.png';
  static String get postMoreIcon => 'assets/img/more_icon.jpg';
  static String get likeOffIcon => 'assets/img/like_off_icon.jpg';
  static String get likeOnIcon => 'assets/img/like_on_icon.jpg';
  static String get replyIcon => 'assets/img/reply_icon.jpg';
  static String get bookMarkOffIcon => 'assets/img/book_mark_off_icon.jpg';
  static String get bookMarkOnIcon => 'assets/img/book_mark_on_icon.jpg';
  static String get backBtnIcon => 'assets/img/back_icon.jpg';
  static String get menuIcon => 'assets/img/menu_icon.jpg';
  static String get addFriend => 'assets/img/add_friend_icon.jpg';
  static String get gridViewOff => 'assets/img/grid_view_off_icon.jpg';
  static String get gridViewOn => 'assets/img/grid_view_on_icon.jpg';
  static String get myTagImageOff => 'assets/img/my_tag_image_off_icon.jpg';
  static String get myTagImageOn => 'assets/img/my_tag_image_on_icon.jpg';
  static String get nextImage => 'assets/img/upload_next_icon.jpg';
  static String get closeImage => 'assets/img/close_icon.jpg';
  static String get imageSelectIcon => 'assets/img/image_select_icon.jpg';
  static String get cameraIcon => 'assets/img/camera_icon.jpg';
  static String get uploadComplete => 'assets/img/upload_complete_icon.jpg';
  static String get mypageBottomSheet01 =>
      'assets/img/mypage_bottom_sheet_01.jpg';
  static String get mypageBottomSheet02 =>
      'assets/img/mypage_bottom_sheet_02.jpg';
  static String get mypageBottomSheet03 =>
      'assets/img/mypage_bottom_sheet_03.jpg';
  static String get mypageBottomSheet04 =>
      'assets/img/mypage_bottom_sheet_04.jpg';
  static String get mypageBottomSheet05 =>
      'assets/img/mypage_bottom_sheet_05.jpg';
  static String get mypageBottomSheetSetting01 =>
      'assets/img/mypage_bottom_sheet_setting_01.jpg';
  static String get mypageBottomSheetSetting02 =>
      'assets/img/mypage_bottom_sheet_setting_02.jpg';
  static String get mypageBottomSheetSetting03 =>
      'assets/img/mypage_bottom_sheet_setting_03.jpg';
  static String get mypageBottomSheetSetting04 =>
      'assets/img/mypage_bottom_sheet_setting_04.jpg';
  static String get mypageBottomSheetSetting05 =>
      'assets/img/mypage_bottom_sheet_setting_05.jpg';
  static String get mypageBottomSheetSetting06 =>
      'assets/img/mypage_bottom_sheet_setting_06.jpg';
  static String get mypageBottomSheetSetting07 =>
      'assets/img/mypage_bottom_sheet_setting_07.jpg';
}
