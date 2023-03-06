import 'package:get/get.dart';
import 'package:homemate/views/login.view.dart';

class splashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void NavigationTimer() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAll(LoginPage());
  }
}
