import 'package:flutter/material.dart';
import 'package:imgage_store_1_app/model/image_model.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/sub_screens/full_view_screen.dart';
import 'package:provider/provider.dart';

class SingleImageContainer extends StatelessWidget {
  const SingleImageContainer({
    Key? key,
    required this.images,
    required this.screenSize,
    required this.index,
  }) : super(key: key);

  final List<ImageModal> images;
  final Size screenSize;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        child: GestureDetector(
          onTap: () {
            Provider.of<ImagesProvider>(context, listen: false)
                .setSingleImage(images[index]);
            Navigator.pushNamed(context, FullViewScreen.pageKey,
                arguments: screenSize);
          },
          child: Image.network(
            images[index].imgURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
