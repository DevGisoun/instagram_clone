/// 데이터 유틸리티 클래스

import 'package:uuid/uuid.dart';

class DataUtil {
  /// 업로드 Post 이미지 파일 포맷 지정
  static String makeFilePath() {
    return '${const Uuid().v4()}.jpg';
  }
}
