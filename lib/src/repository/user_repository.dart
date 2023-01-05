/// 사용자 DB Mapper

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/instagram_user.dart';

/// 사용자 로그인 DB 내 uid 대조
class UserRepository {
  static Future<IUser?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return IUser.fronJson(data.docs.first.data());
    }
  }

  /// 회원가입 시 사용자 객체 DB에 추가
  static Future<bool> signup(IUser user) async {
    try {
      await FirebaseFirestore.instance.collection('user').add(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
