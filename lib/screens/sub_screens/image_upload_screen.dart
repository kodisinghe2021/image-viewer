import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';
import 'package:imgage_store_1_app/utils/util_functions.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  static const pageKey = '/image-upload-screen';

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final TextEditingController _inputtitle = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  //asign empty path for file
  File _image = File("");

  //---------------------uploading function
  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile = await _picker.pickImage(
          source: ImageSource.gallery); // check pickFile is empty or not
      if (pickFile != null) {
        //assign path for file
        _image = File(pickFile.path);
      } else {
        Logger().w("File Not Selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = ModalRoute.of(context)!.settings.arguments as Size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ImageViewScreen.pageKey);
            },
            icon: const Icon(Icons.navigate_before)),
        title: const Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: screenSize.width * 0.7,
            height: screenSize.height * 0.98,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Uplod file',
                  style: TextStyle(fontSize: 20),
                ),
                Consumer<ImagesProvider>(
                  builder: (context, value, child) {
                    return value.getIamage.path == ""
                        ? IconButton(
                            onPressed: () {
                              Provider.of<ImagesProvider>(context,
                                      listen: false)
                                  .selectImage();
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.amber,
                            ),
                          )
                        : SizedBox(
                            width: screenSize.width * 0.97,
                            height: screenSize.height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Image.file(value.getIamage, fit: BoxFit.fill),
                                  TextButton(
                                    onPressed: () {
                                      value.getIamage.path == "";
                                      Provider.of<ImagesProvider>(context,
                                              listen: false)
                                          .selectImage();
                                    },
                                    child: const Text("Select Other Image"),
                                  ),
                                ],
                              ),
                            ),
                          );
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Image Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(28),
                      ),
                    ),
                    // this is the border style of after focus
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  controller: _inputtitle,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Consumer<ImagesProvider>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        onPressed: () async {
                          //check the image is selected or not
                          if (value.getIamage.path == '') {
                            UtilFunctions.showDialogBox(
                              context,
                              CoolAlertType.warning,
                              'Empty',
                              'Select image correctly ',
                              () {},
                            );
                          } else {
                            //check title field is empty or not
                            if (_inputtitle.text.isNotEmpty) {
                              value.startSaveBookInfo(_inputtitle.text.trim());
                              Navigator.pushNamed(
                                  context, ImageViewScreen.pageKey);
                              _inputtitle.clear();
                              value.clearPath();
                              UtilFunctions.showDialogBox(
                                context,
                                CoolAlertType.success,
                                'Success',
                                'Image Upload is Successfull',
                                () {
                                  Navigator.pushNamed(
                                      context, ImageViewScreen.pageKey);
                                },
                              );
                            } else {
                              UtilFunctions.showDialogBox(
                                context,
                                CoolAlertType.warning,
                                'Empty',
                                'Title cannot be empty',
                                () {},
                              );
                            }
                          }
                        },
                        child: const Text("Upload",
                            style: TextStyle(fontSize: 20)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
