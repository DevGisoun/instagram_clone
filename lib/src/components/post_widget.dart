/// Post의 Grid System 구축 및 UI 구성 컴포넌트

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  /// Post의 Header
  /// Avatar, Nickname, onTab()으로 구성
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Post 작성자의 Avatar, Nickname
          AvatarWidget(
            thumbPath: post.userInfo!.thumbnail!,
            type: AvatarType.TYPE3,
            nickname: post.userInfo!.nickname,
            size: 40,
          ),

          /// Post 관련 이벤트(공유, 작성자 팔로우 등) 기능 집합
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Post의 Image Widget
  Widget _image() {
    return CachedNetworkImage(
      imageUrl: post.thumbnail!,
    );
  }

  /// Post의 버튼 집합
  /// 좋아요, 댓글, 디엠, 북마크 기능 구성
  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// Post 좋아요 버튼
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(
                width: 15,
              ),

              /// Post 댓글 조회 버튼
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(
                width: 15,
              ),

              /// Post 작성자 디엠 버튼
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),

          /// Post 북마크 버튼
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 50,
          ),
        ],
      ),
    );
  }

  /// Post의 정보 집합
  /// 좋아요 개수, 작성자 Nickname, 작성 내용 및 Expand 기능으로 구성
  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount ?? 0}개',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ExpandableText(
            post.description ?? '',
            prefixText: post.userInfo!.nickname,
            onPrefixTap: () {
              print('페이지 이동');
            },
            prefixStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            expandOnTextTap: true,
            collapseOnTextTap: true,
            linkColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  /// Post 댓글 개수 및 조회
  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '댓글 222개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  /// Post 작성 일자
  Widget _dateAgo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        timeago.format(post.createdAt!),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _header(),
        const SizedBox(
          height: 15,
        ),
        _image(),
        const SizedBox(
          height: 15,
        ),
        _infoCount(),
        const SizedBox(
          height: 5,
        ),
        _infoDescription(),
        const SizedBox(
          height: 5,
        ),
        _replyTextBtn(),
        const SizedBox(
          height: 5,
        ),
        _dateAgo(),
      ]),
    );
  }
}
