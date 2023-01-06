import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/components/message_popup.dart';
import 'package:instagram_clone/src/controller/auth_controller.dart';
import 'package:instagram_clone/src/model/post.dart';
import 'package:instagram_clone/src/repository/post_repository.dart';
import 'package:instagram_clone/src/utils/data_util.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';

import '../pages/upload/upload_description.dart';

class UploadController extends GetxController {
  /// 디바이스 앨범(이미지 폴더) List
  ///
  /// AssetPathEntity == 앨범을 추상화하는 photo_manager의 클래스
  var albums = <AssetPathEntity>[];

  /// 선택된 앨범 이름
  RxString headerTitle = ''.obs;

  /// 앨범 내 이미지 List
  ///
  /// AssetEntity = Assets(이미지, 비디오, 오디오)을
  /// 추상화하는 photo_manager의 클래스
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;

  /// TextField 변경 반응
  TextEditingController textEditingController = TextEditingController();

  /// 선택된 이미지
  /// (null 허용)
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 1,
    width: 0,
    height: 0,
  ).obs;

  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  /// 갤러리 내 이미지 파일들을 불러오는 함수
  void _loadPhotos() async {
    /// 갤러리 App에 대한 권한 요청 실행 함수
    var result = await PhotoManager.requestPermissionExtend();

    /// if : 권한이 있을 경우 실행
    ///
    /// else : 권한이 없을 경우 권한 요청
    if (result.isAuth) {
      albums =

          /// 앨범 List 불러오기
          await PhotoManager.getAssetPathList(
        type: RequestType.image,

        /// 이미지 최소 사이즈 적용
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(
              minWidth: 100,
              minHeight: 100,
            ),
          ),

          /// 이미지 순서
          orders: [
            /// 최신 이미지 순으로 내림차순 정렬
            const OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );
      _loadData();
    } else {}
  }

  /// Upload 페이지 실행 시 앨범, 이미지 List 초기화
  void _loadData() async {
    changeAlbum(albums.first);
    // update();
  }

  /// 이미지 List에 이미지들을 추가
  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();

    /// 첫 번째 앨범에서 최대 30개의 이미지 불러오기
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    // var photos = await album.getAssetListPaged(0, 30);

    /// 불러온 이미지들을 List에 추가
    imageList.addAll(photos);

    /// 선택된 이미지의 초기 값은 이미지 List의 첫 번째 이미지
    changeSelectedImage(imageList.first);
  }

  /// 선택된 이미지 설정
  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  /// 앨범명 지정 및 앨범 내 사진 불러오기
  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  /// 이미지 필터 적용
  ///
  /// https://pub.dev/packages/photofilters/example
  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(await file.readAsBytes());
    image = imageLib.copyResize(image!, width: 1000);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text('Photo Filter Example'),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  /// 최종 업로드 버튼 터치 시 키보드 Unfocus
  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 최종 업로드
  void uploadPost() {
    unFocusKeyboard();
    var fileName = DataUtil.makeFilePath();
    var task = uploadXFile(
      filteredImage!,
      '/${AuthController.to.user.value.uid}/$fileName',
    );
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          _submitPost(updatedPost);
        }
      });
    }
  }

  /// Firebase Storage에 이미지 메타데이터 전달
  UploadTask uploadXFile(File file, String fileName) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(fileName);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    return ref.putFile(file, metadata);
  }

  /// Post 업로드 및 Dialog 출력
  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
        },
      ),
    );
  }
}
