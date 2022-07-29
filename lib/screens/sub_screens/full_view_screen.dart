import 'package:flutter/material.dart';
import 'package:imgage_store_1_app/controllers/image_controller.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';
import 'package:imgage_store_1_app/screens/sub_screens/image_upload_screen.dart';
import 'package:provider/provider.dart';

class FullViewScreen extends StatelessWidget {
  FullViewScreen({Key? key}) : super(key: key);

  static const pageKey = '/full_view-screen';
  final ImageController _imageController = ImageController();
  // final ImagesProvider _imageProvider = ImagesProvider();
  @override
  Widget build(BuildContext context) {
    final selectedImage = Provider.of<ImagesProvider>(context).getSingleImage;
    final Size screenSize = ModalRoute.of(context)!.settings.arguments as Size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, ImageViewScreen.pageKey);
          },
          icon: const Icon(Icons.navigate_before),
        ),
        title: Text(selectedImage.title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenSize.width * 0.9,
              height: screenSize.height * 0.9,
              color: const Color.fromARGB(255, 187, 223, 243),
              child: Image.network(
                selectedImage.imgURL,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              width: screenSize.width * 0.98,
              height: screenSize.height * 0.1,
              color: Colors.white.withOpacity(0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Delete"),
                  IconButton(
                      onPressed: () async {
                        await _imageController.deleteImage(
                            selectedImage.imgDestination, context);
                        _imageController.deleteDoc(selectedImage.id, context);
                      },
                      icon: const Icon(Icons.delete, size: 40)),
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  const Text("Update"),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ImageUploadScreen.pageKey,arguments:true);
                      },
                      icon: const Icon(Icons.upgrade, size: 40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
