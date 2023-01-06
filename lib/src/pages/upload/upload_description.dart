/// Post 최종 Upload 페이지

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/controller/upload_controller.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({Key? key}) : super(key: key);

  /// 게시글 문구 입력 (TextField)
  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,

              /// 여러 줄 입력 가능
              maxLines: null,

              /// TextField Bottom Line 제거
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 15,
                ),
                hintText: '문구 입력...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 사람 태그, 위치 추가, 다른 미디어 게시 (미구현)
  Widget _infoOne(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7.0,
        horizontal: 15.0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  /// Custom Divider Widget
  Widget get _line => const Divider(
        color: Colors.grey,
      );

  /// 타 SNS 플랫폼 게시 체크 (미구현)
  Widget _snsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Column(
        children: [
          /// Facebook
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Facebook',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),

          /// Twitter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Twitter',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),

          /// Tumblr
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tumblr',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '새 게시물',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.uploadPost,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.uploadComplete,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          /// 빈 화면 터치 시 키보드 내리기 위함
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _description(),
                _line,
                _infoOne('사람 태그하기'),
                _line,
                _infoOne('위치 추가'),
                _line,
                _infoOne('다른 미디어에도 게시'),
                _snsInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
