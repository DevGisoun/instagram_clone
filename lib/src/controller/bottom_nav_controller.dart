/// App 하단 Navigation Bar로부터 발생하는 이벤트 함수들의 집합

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';

import '../components/message_popup.dart';
import '../pages/upload.dart';

/// App 하단 Navigation Bar의 구성 요소들
enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  /// App 하단 Navigation Bar의 중첩 라우팅
  static BottomNavController get to => Get.find();

  /// App 하단 Navigation Bar의 인덱스 초기화 (0 : Home)
  RxInt pageIndex = 0.obs;

  /// 중첩 라우팅을 위한 NavigatorState 타입의 GlobalKey 선언
  GlobalKey<NavigatorState> searchPageNavigationKey =
      GlobalKey<NavigatorState>();

  /// Navigation History List
  List<int> bottomHistory = [0];

  /// App 하단 Navigation Bar Icon 터치 시 실행되는 이벤트 함수
  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.UPLOAD:
        // Get.to(
        //   () => Upload(),
        //   binding: BindingsBuilder(() {
        //     Get.put(UploadController());
        //   }),
        // );
        Get.to(() => Upload());
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  /// App 하단 Navigation Bar Icon 터치 시
  /// Navigation History List에 터치한 Navigation Index 저장
  /// (List 내 Index 중복 불허용)
  /// Home Icon 터치 시 초기화
  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) {
      return;
    }

    // case 1. History Index 중복 불허용
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);

    // // case 2. History Last Index를 제외한 나머지 중복 허용
    // if (bottomHistory.last != value) {
    //   bottomHistory.add(value);
    // }

    if (bottomHistory.length > 1 && bottomHistory.last == 0) {
      bottomHistory = [0];
      return;
    }
  }

  /// 하단 Navigation Bar의 Back 버튼 터치 시 실행되는 함수
  Future<bool> willPopAction() async {
    /// Navigation History List에 Home Index만 남아있다면
    /// 사용자에게 App 종료 여부 팝업창 제출
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
      /// Navigation History List에 Home Index를 포함한
      /// 다른 Index가 함께 남아있다면
      /// List의 마지막 Index를 제거하여 이전 Index 페이지로 복귀
      var page = PageName.values[bottomHistory.last];

      /// 현재 페이지가 Search 페이지라면 중첩 라우팅 체크
      if (page == PageName.SEARCH) {
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if (value) {
          return false;
        }
      }

      bottomHistory.removeLast();

      var lastIndex = bottomHistory.last;
      changeBottomNav(lastIndex, hasGesture: false);
      return false;
    }
  }
}
