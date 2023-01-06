/// App 실행 시 Home 화면에 나타나는 Post List 관리 함수들의 집합

import 'package:get/get.dart';
import 'package:instagram_clone/src/model/post.dart';
import 'package:instagram_clone/src/repository/post_repository.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  /// 사용자들의 Post List 불러오기
  void _loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
  }
}
