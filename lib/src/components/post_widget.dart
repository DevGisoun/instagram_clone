/// Post의 Grid System 구축 및 UI 구성 컴포넌트

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/img_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

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
            thumbPath:
                'https://phantom-marca.unidadeditorial.es/6697dbd875d4e47f339c0db2a27803a1/resize/1320/f/jpg/assets/multimedia/imagenes/2022/03/08/16467404046841.jpg',
            type: AvatarType.TYPE3,
            nickname: 'DevGisoun',
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
      imageUrl:
          'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt0168407a10a76ec9/62ea2c90d7f6b63b71d20721/Talent_Factories_Man_City.jpg',
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
          const Text(
            '좋아요 150개',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ExpandableText(
            '콘텐츠 1 입니다.\n콘텐츠 1 입니다.\n콘텐츠 1 입니다.\n콘텐츠 1 입니다.',
            prefixText: 'DevGisoun',
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1일전',
        style: TextStyle(
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
