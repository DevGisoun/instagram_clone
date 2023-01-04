/// App 실행 시 가장 먼저 보여지는 화면 구성 및 기능 구현

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:instagram_clone/src/pages/active_history.dart';
import 'package:instagram_clone/src/pages/home.dart';

import 'pages/search.dart';

/// controller == BottomNavController
class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          /// App Header, App 하단 Navigation Bar를 제외한
          /// App의 전반적인 초기 구성 및 기능 구현
          body: IndexedStack(
            /// App 페이지 Index 초기화 (0 : Home)
            index: controller.pageIndex.value,
            children: [
              /// Home 터치 시 나타나는 화면 구성
              const Home(),

              /// Search 터치 시 나타나는 화면 구성
              Navigator(
                key: controller.searchPageNavigationKey,
                onGenerateRoute: (routeSetting) {
                  return MaterialPageRoute(
                    builder: (context) => const Search(),
                  );
                },
              ),

              /// Upload Index 부분. 빈 Container()
              Container(),

              /// Activity 터치 시 나타나는 화면 구성
              const ActiveHistory(),

              /// My Page 터치 시 나타나는 화면 구성
              Container(
                child: Center(child: Text('MYPAGE')),
              ),
            ],
          ),

          /// App 하단 Navigation Bar 구성 및 기능 구현
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,

            /// App 하단 Navigation Bar 구성 요소 집합
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeOff),
                activeIcon: ImageData(IconsPath.homeOn),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.searchOff),
                activeIcon: ImageData(IconsPath.searchOn),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.uploadIcon),
                label: 'Upload',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.activeOff),
                activeIcon: ImageData(IconsPath.activeOn),
                label: 'Active',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                label: 'My Page',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
