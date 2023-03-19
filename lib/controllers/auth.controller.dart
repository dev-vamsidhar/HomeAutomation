import 'package:get/get.dart';
import 'package:homemate/controllers/localStorage.controller.dart';
import 'package:homemate/views/home.view.dart';
import 'package:homemate/views/login.view.dart';

class AuthenticationController {
  void login(String deviceId, String passCode) async {
    LocalStorage localStorage = Get.put(LocalStorage());
    await localStorage.setData("isLoggedin", "true");
    Get.offAll(HomePage());
  }

  void logout() async {
    LocalStorage localStorage = Get.put(LocalStorage());
    await localStorage.removeKey("isLoggedin");
    Get.offAll(LoginPage());
  }
}
