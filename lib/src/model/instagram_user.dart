/// Instagram_Clone 사용자 객체

class IUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;

  /// 사용자 입력 정보 인스턴스화
  IUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
  });

  /// 사용자 입력 정보 무결성 체크
  factory IUser.fromJson(Map<String, dynamic> json) {
    return IUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
    );
  }

  /// 사용자 입력 정보 Map Parsing
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
    };
  }

  /// 사용자 입력 정보 객체 형태로 복제
  ///
  /// 입력된 정보에 따라 Default 값 또는 입력 값으로 변경
  IUser copyWith({
    String? uid,
    String? nickname,
    String? thumbnail,
    String? description,
  }) {
    return IUser(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
    );
  }
}
