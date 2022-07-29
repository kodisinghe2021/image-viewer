import 'package:flutter/material.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/sub_screens/image_upload_screen.dart';
import 'package:imgage_store_1_app/utils/util_functions.dart';
import 'package:imgage_store_1_app/widgets/single_image_container.dart';
import 'package:provider/provider.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/images_view-screen';

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  //fetch data when open this page
  @override
  void initState() {
    UtilFunctions.fetchImages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final images = Provider.of<ImagesProvider>(context).getImageList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ImageUploadScreen.pageKey,
                  arguments: screenSize);
            },
            icon: const Icon(Icons.file_upload_outlined)),
        title: const Text(
          "Image Window",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap:(){
              setState(() {
                UtilFunctions.fetchImages(context);
              });
            },
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
              color: const Color.fromARGB(255, 224, 221, 210),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => SingleImageContainer(
                  images: images,
                  screenSize: screenSize,
                  index: index,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
