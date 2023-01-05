/// 회원가입 페이지 UI 구축 및 기능 구현

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/instagram_user.dart';

class SignupPage extends StatefulWidget {
  final String uid;

  /// 사용자의 uid 요청
  const SignupPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  /// TextField에 입력되는 nickname Value 업데이트
  TextEditingController nicknameController = TextEditingController();

  /// TextField에 입력되는 description Value 업데이트
  TextEditingController descriptionController = TextEditingController();

  /// 회원가입 시 Avatar(프로필 이미지) 등록
  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/img/default_image.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('이미지 변경'),
        ),
      ],
    );
  }

  /// 회원가입 시 사용자 Nickname 등록
  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  /// 회원가입 시 사용자 설명 등록
  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
      ),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            _avatar(),
            const SizedBox(
              height: 30,
            ),
            _nickname(),
            const SizedBox(
              height: 30,
            ),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 50,
        ),
        child: ElevatedButton(
          onPressed: () {
            /// '회원가입' 버튼 터치 시 uid, 사용자의 닉네임, 설명을
            /// 기반으로한 IUser 인스턴스 생성
            var signupUser = IUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              description: descriptionController.text,
            );

            /// 반환받은 IUser 인스턴스를 전달하여 회원가입 실행
            AuthController.to.signup(signupUser);
          },
          child: const Text('회원가입'),
        ),
      ),
    );
  }
}
