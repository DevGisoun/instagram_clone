/// App 실행 시 가장 먼저 실행되는 파일

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/src/app.dart';
import 'package:instagram_clone/src/binding/init_bindings.dart';
import 'package:instagram_clone/src/root.dart';

void main() async {
  /// Firebase의 Flutter Engine과의 상호작용 시도
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
          )),
      initialBinding: InitBinding(),

      /// App 실행 시 Root를 거쳐
      /// 사용자 데이터가 등록되어있는지 판별 후
      /// Home 또는 Login 페이지로 이동
      home: const Root(),
    );
  }
}
