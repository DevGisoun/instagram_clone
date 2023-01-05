/// App 실행 시 App() 보다 우선적으로 실행
///
/// 사용자 계정 Firebase 존재 여부 체크

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/pages/login.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),

        /// 사용자 데이터 존재 여부 체크 후 페이지 이동
        builder: (BuildContext _, AsyncSnapshot<User?> user) {
          if (user.hasData) {
            return const App();
          } else {
            return const Login();
          }
        });
  }
}
