import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imgage_store_1_app/provider/images_provider.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';
import 'package:imgage_store_1_app/screens/splash_screen/splash_screen.dart';
import 'package:imgage_store_1_app/screens/sub_screens/full_view_screen.dart';
import 'package:imgage_store_1_app/screens/sub_screens/image_upload_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //providing class
      create: (context) => ImagesProvider(),

      child: MaterialApp(
        routes: {
          FullViewScreen.pageKey: (context) => FullViewScreen(),
          ImageViewScreen.pageKey: (context) => const ImageViewScreen(),
          ImageUploadScreen.pageKey: (context) => ImageUploadScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
