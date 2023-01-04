/// 간소화된 다른 사용자 프로필 템플릿 컴포넌트

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;

  /// 사용자별 프로필 카드 인스턴스화
  const UserCard({
    Key? key,
    required this.userId,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 3.0,
      ),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          /// 사용자별 정보
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),

                /// 사용자별 Avatar
                AvatarWidget(
                  thumbPath:
                      'https://w.namu.la/s/69e022275d62e3352d39ad1fd31409efcb15e4c04351b1e762a67ba81d2958980243de23a759e4b306a78f327173139f61cb10fe8f5034187b670470df724252670f7e81d5e148e6e1f4e65a14ba77ad1f8b913aadf529001ce4deb0b0fc6e42',
                  type: AvatarType.TYPE2,
                  size: 80,
                ),
                const SizedBox(
                  height: 10,
                ),

                /// mypage.dart로부터 전달받은 userId 출력
                Text(
                  userId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                /// mypage.dart로부터 전달받은 description 출력
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),

                /// Follow 버튼
                ///
                /// ElevatedButton == Flutter에서 제공하는 Material Design 버튼
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Follow',
                  ),
                ),
              ],
            ),
          ),

          /// 카드 Close 버튼
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
