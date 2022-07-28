import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:provider/provider.dart';

class UtilFunctions {
  static Future<dynamic> showDialogBox(
      BuildContext context,
      CoolAlertType alertType,
      String title,
      String text,
      Function onTap) async {
    return CoolAlert.show(
      context: context,
      type: alertType,
      title: title,
      text: text,
      animType: CoolAlertAnimType.rotate,
      borderRadius: 30,
      onConfirmBtnTap: onTap(),
    );
  }

 static Future<dynamic> fetchImages(BuildContext context) async {
    await Provider.of<ImagesProvider>(context, listen: false).fetchImage();
  }
}
