/// Search 페이지에서 검색 필드 터치 시 넘어오는
/// 텍스트 필드가 존재하는 검색 페이지

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/controller/bottom_nav_controller.dart';

class SearchForcus extends StatefulWidget {
  const SearchForcus({Key? key}) : super(key: key);

  @override
  State<SearchForcus> createState() => _SearchForcusState();
}

class _SearchForcusState extends State<SearchForcus>
    with TickerProviderStateMixin {
  late TabController tabController;

  /// Tab의 개수 정의 및 초기화
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  /// 각 Tab의 UI
  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  /// 검색 Tab Menu UI 제작, 기능 구현 및 구성 요소
  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffe4e4e4),
            ),
          ),
        ),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: [
            _tabMenuOne('인기'),
            _tabMenuOne('계정'),
            _tabMenuOne('오디오'),
            _tabMenuOne('태그'),
            _tabMenuOne('장소'),
          ],
        ),
      ),
    );
  }

  /// Tab의 내용 출력
  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(
          child: Text('인기 페이지'),
        ),
        Center(
          child: Text('계정 페이지'),
        ),
        Center(
          child: Text('오디오 페이지'),
        ),
        Center(
          child: Text('태그 페이지'),
        ),
        Center(
          child: Text('장소 페이지'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        /// 검색 Text Field 좌측 Back 버튼 구현
        ///
        /// BottomNavController의 willPopAction 함수 호출
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.backBtnIcon,
            ),
          ),
        ),
        titleSpacing: 0,

        /// 검색 Text Field UI 구성
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(
                left: 15,
                top: 7,
                bottom: 7,
              ),
              isDense: true,
            ),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}
