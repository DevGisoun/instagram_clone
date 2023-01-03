import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => const Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) {
      return;
    }

    // v1. History Index 중복 불허용
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);

    // // v2. History Last Index를 제외한 나머지 중복 허용
    // if (bottomHistory.last != value) {
    //   bottomHistory.add(value);
    // }

    if (bottomHistory.length > 1 && bottomHistory.last == 0) {
      bottomHistory = [0];
      return;
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
          message: '종료하시겠습니까 ?',
          okCallback: () {
            exit(0);
          },
          cancelCallback: Get.back,
          title: 'System',
        ),
      );
      return true;
    } else {
      bottomHistory.removeLast();

      var lastIndex = bottomHistory.last;
      changeBottomNav(lastIndex, hasGesture: false);
      return false;
    }
  }
}
