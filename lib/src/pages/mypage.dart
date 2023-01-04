/// My Page 터치 시 나타나는 화면 구성

import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/components/user_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  /// 사용자 Infomation 템플릿
  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  /// 사용자 정보
  ///
  /// (사용자 Avatar, Post, Followers, Following, 자기소개 존재)
  Widget _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 사용자 Avatar, Post, Followers, Following
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarWidget(
                thumbPath:
                    'https://w.namu.la/s/3049fe7bc95b17fa7a23ed680e4a93defb20c588c3141e7e5bbf0a2aa9a964b620543dcf965745602bd84cebe6a879ae35ea56500a6d598d71305cd29d1f10bf10022dd1d9128d564976eed880e0354f997cdc9967bf8481dea3d93e4ab013d9',
                type: AvatarType.TYPE3,
                size: 80,
              ),
              const SizedBox(
                width: 10,
              ),

              /// 사용자 Infomation을 그룹으로 묶어
              /// 균등한 간격으로 Expanded 조정
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _statisticsOne('Post', 15)),
                    Expanded(child: _statisticsOne('Followers', 11)),
                    Expanded(child: _statisticsOne('Following', 3)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          /// 자기소개
          const Text(
            '안녕! DevGisoun 이라고 해~ 잘부탁해잘부탁해잘부탁해잘부탁해',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  /// 사용자 메뉴
  ///
  /// (Edit Profile, Add Follow Icon 존재)
  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 25,
      ),
      child: Row(
        children: [
          /// Edit Profile Icon (Expanded)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: const Color(0xffdedede),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),

          /// Add Follow Icon
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(
              IconsPath.addFriend,
            ),
          ),
        ],
      ),
    );
  }

  /// 간소화된 다른 사용자 프로필
  ///
  /// (Widget Title, See All 버튼, 다른 사용자 프로필 존재)
  Widget _discoverPeople() {
    return Column(
      children: [
        /// Widget Title, See All 버튼
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),

        /// 간소화된 다른 사용자 프로필 List
        ///
        /// 가로 스크롤 기능
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: List.generate(
              10,
              (index) => UserCard(
                userId: 'DevGisoun$index',
                description: '기순$index님이 팔로우합니다.',
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }

  // My Page 내 Tab Menu
  Widget _tabMenu() {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: ImageData(
            IconsPath.gridViewOn,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: ImageData(
            IconsPath.myTagImageOff,
          ),
        ),
      ],
    );
  }

  /// Tab Menu 내 Tab View
  Widget _tabView() {
    return GridView.builder(
      /// NeverScrollableScrollPhysics:
      ///
      /// Scaffold의 body 란에서 이미 Scroll이 적용되었기에
      /// 사용자가 Scroll 할 수 없도록 하는 물리 함수
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 100,

      /// 타일 수가 고정된 Grid Layout 구축
      ///
      /// (N, 3) 행렬의 Grid System
      ///
      /// Grid 가로 및 세로 비율 1
      ///
      /// Grid 좌우 간격 1
      ///
      /// Grid 수직 간격 1
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),

      /// Grid Item(사용자가 업로드한 이미지) Builder
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// My Page Header
      ///
      /// 사용자 닉네임, 업로드 및 메뉴 Icon 존재
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'DevGisoun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            const SizedBox(
              height: 20,
            ),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}
