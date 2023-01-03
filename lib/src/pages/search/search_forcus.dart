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

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    );
  }

  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        decoration: BoxDecoration(
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
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

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
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xffefefef),
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
