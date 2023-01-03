/// App 하단 Navagation Bar 인스턴스 종속성 관리

import 'package:get/get.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
  }
}
