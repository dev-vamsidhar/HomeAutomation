import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/localStorage.controller.dart';
import 'package:homemate/views/home.view.dart';
import 'package:homemate/views/login.view.dart';
import 'package:homemate/views/navigation.view.dart';

class AuthenticationController {
  void login(String username, String password) async {
    try {
      EasyLoading.show(status: "Logging in...");
      LocalStorage localStorage = Get.put(LocalStorage());

      DataSnapshot snapshot =
          await FirebaseDatabase.instance.ref("users/").get();
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      if (data[username] == null) {
        EasyLoading.showError("User not found");
        return;
      } else {
        if (data[username]["password"] == password) {
          await localStorage.setData("isLoggedin", "true");
          await localStorage.setData("username", username);
          EasyLoading.showSuccess("Logged in");
          Get.offAll(Navigation());
        } else {
          EasyLoading.showError("Incorrect password");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    LocalStorage localStorage = Get.put(LocalStorage());
    await localStorage.removeKey("isLoggedin");
    Get.offAll(LoginPage());
  }
}
