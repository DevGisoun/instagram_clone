/// App 실행 시 사용자 로그인에 대한 이벤트 함수들의 집합

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/repository/user_repository.dart';

import '../binding/init_bindings.dart';
import '../model/instagram_user.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  /// IUser 타입의 사용자 지정
  Rx<IUser> user = IUser().obs;

  /// DB 내 사용자 필드 Return
  Future<IUser?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);

    if (userData != null) {
      user(userData);
      InitBinding.additionalBinding();
    }

    return userData;
  }

  /// 회원가입 Mapper에 IUser 인스턴스와 프로필 사진 전달 후 사용자 초기화(Set)
  void signup(IUser signupUser, XFile? thumbnail) async {
    /// if : 프로필 사진 지정을 하지 않았을 경우 IUser 인스턴스만을 전달하여
    /// 회원가입
    ///
    /// else : 프로필 사진을 지정하였다면 이미지(XFile) 업로드
    if (thumbnail == null) {
      _submitSignup(signupUser);
    } else {
      /// 이미지 확장자 추출
      var extension = thumbnail.path.split('.').last;

      /// users/{uid}/profile.{extension}
      var task = uploadXFile(
        thumbnail,
        '${signupUser.uid}/profile.$extension',
      );
      task.snapshotEvents.listen((event) async {
        /// 업로드한 이미지의 크기와 Snapshot에 있는 이미지의 크기 대조
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          /// 업로드한 이미지 파일의 URL 추출
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedUserData = signupUser.copyWith(
            thumbnail: downloadUrl,
          );
          _submitSignup(updatedUserData);
        }
      });
    }
  }

  /// Firebase Storage에 이미지 메타데이터 전달
  UploadTask uploadXFile(XFile file, String fileName) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    return ref.putFile(f, metadata);
  }

  /// IUser 인스턴스 DB Mapper에 전달
  ///
  /// true를 반환받았다면 로그인 시도
  void _submitSignup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      loginUser(signupUser.uid!);
    }
  }
}
