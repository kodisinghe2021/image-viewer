import 'package:flutter/material.dart';
import 'package:imgage_store_1_app/screens/main_screens/images_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLoginPage();
    super.initState();
  }

  void navigateToLoginPage() {
    Future.delayed(const Duration(seconds: 3), () {
      // this function is available in the utilfunction
      Navigator.pushNamed(context, ImageViewScreen.pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Image Viewer",
                style: TextStyle(fontSize: 40, color: Colors.amber),
              ),
              Text(
                "Images collecting app",
                style: TextStyle(fontSize: 20, color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
