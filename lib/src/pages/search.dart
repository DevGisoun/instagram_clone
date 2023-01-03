/// App 하단 Navigation Bar의 Search Icon 터치 시
/// 첫 번째로 나타나는 다른 사용자들이 업로드한 이미지 리스트 출력 페이지

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/pages/search/search_forcus.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  /// 이미지의 Grid는 (N, 3) 행렬로 구성
  List<List<int>> groupBox = [[], [], []];

  /// 2개의 행을 차지하는 이미지를 구분짓기 위한 Index List
  List<int> groupIndex = [0, 0, 0];

  /// Search 페이지 진입 시 이미지를 각각의 행렬로 초기화하는 함수
  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 100; i++) {
      var gi = groupIndex.indexOf(min<int>(groupIndex)!);
      var size = 1;

      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }

      groupBox[gi].add(size);
      groupIndex[gi] += size;
    }
  }

  /// Search 페이지의 App Header Widget
  Widget _appbar() {
    return Row(
      children: [
        /// Search 페이지의 검색 필드
        ///
        /// 터치 시 Search Focus 페이지로 이동
        Expanded(
          child: GestureDetector(
            onTap: () {
              // // case 1. Getx를 통한 페이지 이동
              // Get.to(SearchForcus());

              // case 2. 중첩 라우터 사용을 통한 페이지 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchForcus(),
                ),
              );
            },

            /// 검색 필드 내 구성 요소들의 집합
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xffefefef),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search),
                  Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff838383),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// 현재 위치 Icon
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  /// initState를 통해 얻은 행렬로 이미지를 출력
  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (index) => Expanded(
            child: Column(
              children: List.generate(
                groupBox[index].length,
                (jndex) => Container(
                  height: Get.width * 0.33 * groupBox[index][jndex],
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://imgresizer.eurosport.com/unsafe/1200x0/filters:format(jpeg):focal(1299x229:1301x227)/origin-imgresizer.eurosport.com/2022/04/05/3350406-68488388-2560-1440.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ).toList(),
            ),
          ),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }
}
