/// Instagram_Clone 사용자 객체

class IUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;

  /// 사용자 계정 정보 인스턴스화
  IUser({
    this.uid,
    this.nickname,
    this.thumbnail,
    this.description,
  });

  factory IUser.fronJson(Map<String, dynamic> json) {
    return IUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickname': nickname,
      'thumbnail': thumbnail,
      'description': description,
    };
  }
}
