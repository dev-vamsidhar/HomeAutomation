import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemate/views/home.view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _deviceIdController = TextEditingController();
  final _passCodeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white, // Dark theme background color
          body: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Image.asset("assets/images/homemate.png"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _deviceIdController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsDirectional.only(
                        start: 10, end: 10, top: 10, bottom: 10),
                    border: OutlineInputBorder(),
                    hintText: 'Enter the device ID',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passCodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsDirectional.only(
                        start: 10, end: 10, top: 10, bottom: 10),
                    border: OutlineInputBorder(),
                    hintText: 'Enter the passcode',
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Get.to(HomePage());
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFF3871b6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Access my home',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
