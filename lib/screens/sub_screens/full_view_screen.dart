import 'package:flutter/material.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';
import 'package:provider/provider.dart';

class FullViewScreen extends StatelessWidget {
  const FullViewScreen({Key? key}) : super(key: key);
  static const pageKey = '/full_view-screen';
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
        title: const Text('Image Full View'),
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
                      onPressed: () {},
                      icon: const Icon(Icons.delete, size: 40)),
                  SizedBox(
                    width: screenSize.width * 0.2,
                  ),
                  const Text("Update"),
                  IconButton(
                      onPressed: () {},
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
