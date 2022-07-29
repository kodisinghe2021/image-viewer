import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgage_store_1_app/controllers/image_controller.dart';
import 'package:imgage_store_1_app/model/image_model.dart';
import 'package:logger/logger.dart';

class ImagesProvider with ChangeNotifier {
  List<ImageModal> _imageList = [];

//fetch book
  Future<void> fetchImage() async {
    try {
      _imageList = await _imageController.getImages();
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  // reutrn image list *copy*, when someone call this func
  List<ImageModal> get getImageList => [..._imageList];

  final ImagePicker _picker = ImagePicker();

  final ImageController _imageController = ImageController();

  //asign empty path for file
  File _image = File("");

  // image getter
  File get getIamage => _image;

  //---------------------uploading function
  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile = await _picker.pickImage(
          // check pickFile is empty or not
          source: ImageSource.gallery);
      if (pickFile != null) {
        //assign path for file
        _image = File(pickFile.path);
        notifyListeners();
      } else {
        Logger().w("File Not Selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

//save book information
  Future<void> startSaveBookInfo(String title) async {
    try {
      await _imageController.saveImageInformation(title, _image);
      notifyListeners();
    } catch (e) {
      Logger().e(" fire base error: $e");
    }
  }

  // clear image path
  void clearPath() {
    _image = File("");
  }

  //empty instance with late keyword
  late ImageModal _imageModal;

//Send single book
  ImageModal get getSingleImage {
    return _imageModal;
  }

  // Adding selected image
  void setSingleImage(ImageModal model) {
    _imageModal = model;
    notifyListeners();
  }

  // update image
  Future<void> updateImage(File img, String destination) async {
    try {
      await FirebaseStorage.instance.ref(destination).putFile(img);
      Logger().i('Update success');
    } catch (e) {
      Logger().e(e);
    }

    //  storage.ref(`/images/${imageAsFile.name}`).put(imageAsFile);
  }
}
