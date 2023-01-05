/// App 실행 시 App() 보다 우선적으로 실행
///
/// 사용자 계정 Firebase 존재 여부 체크 후 페이지 이동

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';
import 'package:instagram_clone/src/pages/login.dart';
import 'package:instagram_clone/src/pages/signup_page.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// stream 속성과 상호 작용에 관한 최신 스냅샷을 기반으로 빌드되는 Widget
    return StreamBuilder(

        /// 현재 Builder에 연결되어 있는 비동기 연산
        ///
        /// 사용자에 대한 변화를 Stream으로 전송
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          /// 사용자 데이터 존재 여부 체크 후 페이지 이동
          ///
          /// if : 사용자 데이터가 존재한다면 DB 조회
          ///
          /// else : 그렇지 않다면 Login 페이지로 이동
          if (user.hasData) {
            // 내부 Firebase 사용자 정보 조회 with. user.data.uid
            return FutureBuilder<IUser?>(
              future: controller.loginUser(user.data!.uid),
              builder: (context, snapshot) {
                /// if : Snapshot에 데이터가 존재한다면 App 화면으로 이동
                ///
                /// else : 그렇지 않다면 uid 체크를 한 뒤,
                /// App 화면으로 이동 또는
                /// uid 전달 후 회원가입 화면으로 이동
                if (snapshot.hasData) {
                  return const App();
                } else {
                  return Obx(() => controller.user.value.uid != null
                      ? const App()
                      : SignupPage(
                          uid: user.data!.uid,
                        ));
                }
              },
            );
          } else {
            return const Login();
          }
        });
  }
}
