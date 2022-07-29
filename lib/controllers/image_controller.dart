import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:imgage_store_1_app/model/image_model.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';
import 'package:imgage_store_1_app/utils/util_functions.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class ImageController {
  String _destinationS = "";
  //image collection refference
  CollectionReference imagesFirestoreInstance =
      FirebaseFirestore.instance.collection('images');

  //save images information func
  Future<void> saveImageInformation(String title, File image) async {
    //upload image to firebase store
    UploadTask? task = uploadFile(image);

    //file is uploading.....
    final snapShot = await task!.whenComplete(() {});

    // get download url
    final downloadUrl = await snapShot.ref.getDownloadURL();

    //Auto create an unique id for image
    String docID = imagesFirestoreInstance.doc().id;
    // Save the image details on cloud firestore
    await imagesFirestoreInstance.doc(docID).set({
      'id': docID,
      'title': title,
      'imageUrl': downloadUrl,
      'imgDestination': _destinationS,
    });
  }

  // upload piked image to the firebase storage
  UploadTask? uploadFile(File image) {
    try {
      // catch the file name from file path of the device
      final fileName = basename(image.path);

      //defining the destination of the firebase storage
      final destination = 'images/$fileName';

      //asign destination value
      _destinationS = destination;
      //creating firebase storage instance with the destination location
      final referenceOfstorage = FirebaseStorage.instance.ref(destination);
      //save file on store
      return referenceOfstorage.putFile(image);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //fetch image list
  Future<List<ImageModal>> getImages() async {
    try {
      List<ImageModal> list = [];

      // query for feching all data
      QuerySnapshot querySnapshot = await imagesFirestoreInstance.get();

      for (var element in querySnapshot.docs) {
        ImageModal modal =
            ImageModal.fromjson(element.data() as Map<String, dynamic>);
        list.add(modal);
      }
      return list;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  // delete firebase storage image by path
  Future<void> deleteImage(String des, BuildContext context) async {
    try {
      final referenceOfstorage = FirebaseStorage.instance.ref(des);
      referenceOfstorage.delete();
      UtilFunctions.showDialogBox(
        context,
        CoolAlertType.success,
        'Success',
        'Image Deleted Successfully',
        () {
          Navigator.pushNamed(context, ImageViewScreen.pageKey);
        },
      );
    } catch (e) {
      Logger().e(e);
    }
  }

// delete firebase document by path
  Future<void> deleteDoc(String id, BuildContext context) async {
    try {
      imagesFirestoreInstance.doc(id).delete();
      await UtilFunctions.showDialogBox(
        context,
        CoolAlertType.success,
        'Success',
        'Image Upload is Successfull',
        () {
          Navigator.pushNamed(context, ImageViewScreen.pageKey);
        },
      );
    } catch (e) {
      Logger().e(e);
    }
  }

}
