/// 본 프로젝트에서 사용되는 Avatar Widget 구성

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// TYPE1 : Story에 나타나는 다른 사용자의 Avatar
///
/// TYPE2 : Story에 나타나는 사용자의 Avatar
///
/// TYPE3 : Post에 나타나는 사용자 또는 다른 사용자의 Avatar
enum AvatarType {
  TYPE1,
  TYPE2,
  TYPE3,
}

class AvatarWidget extends StatelessWidget {
  /// 사용자별 Story 유무
  bool? hasStory;

  /// 사용자별 프로필사진
  String thumbPath;

  /// 사용자별 닉네임
  String? nickname;

  /// 용도별 사용되는 Avatar Type
  AvatarType type;

  /// Avatar Size
  double? size;

  /// TYPE별 Avatar 인스턴스화
  AvatarWidget({
    Key? key,
    this.hasStory,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size = 65,
  }) : super(key: key);

  /// Avatar Widget TYPE1
  Widget type_1_Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: type_2_Widget(),
    );
  }

  /// Avatar Widget TYPE2
  Widget type_2_Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size!),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// Avatar Widget TYPE3
  Widget type_3_Widget() {
    return Row(
      children: [
        type_1_Widget(),
        Text(
          nickname ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type_1_Widget();
      case AvatarType.TYPE2:
        return type_2_Widget();
      case AvatarType.TYPE3:
        return type_3_Widget();
    }

    return Container();
  }
}
