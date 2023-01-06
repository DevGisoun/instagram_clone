/// Post DB Mapper

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/src/model/post.dart';

class PostRepository {
  /// Post 업로드 시 Post 객체 DB에 추가
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  /// DB에 존재하는 Post List 최대 10개를
  /// 등록일의 내림차순으로 정렬하여 반환
  static Future<List<Post>> loadFeedList() async {
    var documents = FirebaseFirestore.instance
        .collection('posts')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .limit(10);

    var data = await documents.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}
