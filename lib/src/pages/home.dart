import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/avatar_widget.dart';
import 'package:instagram_clone/src/components/img_data.dart';
import 'package:instagram_clone/src/components/post_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbPath:
              'https://phantom-marca.unidadeditorial.es/6697dbd875d4e47f339c0db2a27803a1/resize/1320/f/jpg/assets/multimedia/imagenes/2022/03/08/16467404046841.jpg',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          _myStory(),
          const SizedBox(
            width: 5,
          ),
          ...List.generate(
            100,
            (index) => AvatarWidget(
              thumbPath:
                  'https://phantom-marca.unidadeditorial.es/ab0445f3f9673b4345a7028fffa6ec2a/resize/1320/f/jpg/assets/multimedia/imagenes/2022/11/24/16692686054980.jpg',
              type: AvatarType.TYPE1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _postList() {
    return Column(
      children: List.generate(
        50,
        (index) => PostWidget(),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList(),
        ],
      ),
    );
  }
}
