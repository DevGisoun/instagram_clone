/// Post Upload 시 이미지 선택 페이지

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  /// 디바이스 앨범(이미지 폴더) List
  ///
  /// AssetPathEntity == 앨범을 추상화하는 photo_manager의 클래스
  var albums = <AssetPathEntity>[];

  /// 선택된 앨범 이름
  var headerTitle = '';

  /// 앨범 내 이미지 List
  ///
  /// AssetEntity = Assets(이미지, 비디오, 오디오)을
  /// 추상화하는 photo_manager의 클래스
  var imageList = <AssetEntity>[];

  /// 선택된 이미지
  /// (null 허용)
  AssetEntity? selectedImage;

  @override
  void initState() {
    super.initState();
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
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  /// 이미지 List에 이미지들을 추가
  Future<void> _pagingPhotos() async {
    /// 첫 번째 앨범에서 최대 30개의 이미지 불러오기
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);

    /// 불러온 이미지들을 List에 추가
    imageList.addAll(photos);

    /// 선택된 이미지의 초기 값은 이미지 List의 첫 번째 이미지
    selectedImage = imageList.first;
  }

  /// 변경된 Object의 상태(값) 적용
  void update() => setState(() {});

  /// 선택된 이미지 미리보기
  Widget _imagePreview() {
    /// 이미지의 가로/세로 길이 지정
    ///
    /// Get.width == MediaQuery.of(context).size.width
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width,
      color: Colors.grey,

      /// 이미지가 없을 경우 빈 Container()로 대체,
      /// 이미지가 존재할 경우
      child: selectedImage == null
          ? Container()
          : _photoWidget(
              selectedImage!,
              width.toInt(),
              // data == Snapshot에 위치한 이미지 데이터
              builder: (data) {
                return Image.memory(
                  data,

                  /// 지정한 영역 전체 채우기 (비율 유지)
                  fit: BoxFit.cover,
                );
              },
            ),
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
          GestureDetector(
            onTap: () {
              /// 하단에 Modal 출력
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                isScrollControlled: albums.length > 10 ? true : false,

                /// Modal의 최대 Height =
                /// 디바이스의 Height - 상단바 Height
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                ),

                /// 앨범의 길이에 따라 다르게 적용되는 Modal Height
                builder: (_) => Container(
                  height: albums.length > 10
                      ? Size.infinite.height
                      : albums.length * 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,

                            /// 앨범 List의 길이만큼 Column 생성
                            children: List.generate(
                              albums.length,
                              (index) => Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                child: Text(albums[index].name),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

            /// 앨범명 그룹 표현
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                  ),
                ],
              ),
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
      itemCount: imageList.length,

      /// Grid Item(앨범 내 이미지) Builder
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(
          imageList[index],
          200,
          builder: (data) {
            return GestureDetector(
              onTap: () {
                selectedImage = imageList[index];
                update();
              },

              /// 선택된 이미지의 경우 흰색 투명 색상 적용
              child: Opacity(
                opacity: imageList[index] == selectedImage ? 0.3 : 1,
                child: Image.memory(
                  data,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// 선택된 이미지, 이미지 사이즈, builder를 매개변수로 받아
  /// child 요소로 들어가는 Widget
  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),

      /// 비동기 통신을 통해 이미지 데이터 응답 호출
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        /// if : 응답받은 이미지가 있을 경우 정상 Return
        ///
        /// else : 더이상 응답받은 이미지가 없다면 빈 Container() Return
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return Container();
        }
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

        /// Close Icon
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage,
            ),
          ),
        ),

        /// App Bar Title
        title: const Text(
          'New Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        /// 다음 페이지 이동 Icon
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
