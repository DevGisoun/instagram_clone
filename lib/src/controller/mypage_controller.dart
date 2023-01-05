import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class MyPageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  /// My Page Tab 초기화
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    _loadData();
  }

  /// My Page 구분(사용자 또는 다른 사용자)
  void setTargetUser() {
    var uid = Get.parameters['targetUid'];

    /// if : 불러온 uid가 null이라면 사용자 본인 My Page
    /// else : uid가 존재한다면 다른 사용자 My Page
    if (uid == null) {
      targetUser(AuthController.to.user.value);
    } else {
      /// 다른 사용자 uid로 user collection 조회
    }
  }

  /// My Page의 데이터 불러오기
  void _loadData() {
    setTargetUser();

    /// Post List Load
    /// User Info List Load
  }
}
