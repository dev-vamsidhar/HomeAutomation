import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/localStorage.controller.dart';
import 'package:homemate/views/home.view.dart';
import 'package:homemate/views/login.view.dart';
import 'package:homemate/views/navigation.view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int width = 100;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        width = 200;
      });
    });
    Future.delayed(Duration(seconds: 2), () async {
      LocalStorage storage = Get.put(LocalStorage());
      bool isLoggedin = await storage.hasKey("isLoggedin");
      if (isLoggedin) {
        Get.offAll(Navigation());
      } else {
        Get.offAll(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
                width: width.toDouble(),
                duration: Duration(seconds: 3),
                child: Image.asset(
                  "assets/images/homemate.png",
                )),
          ],
        ),
      ),
    );
  }
}
