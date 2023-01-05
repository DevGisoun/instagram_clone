/// App 실행 시 사용자 로그인에 대한 이벤트 함수들의 집합

import 'package:get/get.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

import '../model/instagram_user.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  /// IUser 타입의 사용자 지정
  Rx<IUser> user = IUser().obs;

  /// DB 내 사용자 필드 Return
  Future<IUser?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    return userData;
  }

  /// 회원가입 Mapper에 IUser 객체 전달 후 사용자 초기화(Set)
  void signup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      user(signupUser);
    }
  }
}
