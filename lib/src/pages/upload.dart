/// Post Upload 시 이미지 선택 페이지

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/img_data.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  /// 선택된 이미지 미리보기
  Widget _imagePreview() {
    return Container(
      width: Get.width,
      height: Get.width,
      color: Colors.grey,
    );
  }

  /// 이미지 선택 그룹 및 이미지 다중 선택, 직접 촬영 아이콘 Widget
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 이미지 선택 그룹
          ///
          /// (디바이스 저장소, 갤러리 등)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: const [
                Text(
                  '갤러리',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          Row(
            children: [
              /// 이미지 다중 선택
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(children: [
                  ImageData(
                    IconsPath.imageSelectIcon,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    '여러 항목 선택',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                width: 5,
              ),

              /// 이미지 직접 촬영
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 선택 가능한 이미지 리스트 GridView
  Widget _imageSelectList() {
    return GridView.builder(
      /// NeverScrollableScrollPhysics:
      ///
      /// Scaffold의 body 란에서 이미 Scroll이 적용되었기에
      /// 사용자가 Scroll 할 수 없도록 하는 물리 함수
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,

      /// 타일 수가 고정된 Grid Layout 구축
      ///
      /// (N, 4) 행렬의 Grid System
      ///
      /// Grid 가로 및 세로 비율 1
      ///
      /// Grid 좌우 간격 1
      ///
      /// Grid 수직 간격 1
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// Upload 페이지 App Bar의 UI 및 터치 이벤트 구성
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage,
            ),
          ),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          ),
        ],
      ),

      /// Upload 페이지의 Grid System UI 및 Scroll 기능 구현
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
