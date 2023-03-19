import 'package:get/get.dart';
import 'package:homemate/controllers/firebase.controller.dart';
import 'package:homemate/controllers/localStorage.controller.dart';
import 'package:homemate/views/initialise.view.dart';

class AutomationController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  

  Future intialiseAllpins({required String deviceName}) async {
    try {
      FirebaseController firebaseController = Get.put(FirebaseController());
      await firebaseController.saveData(dbPath: "$deviceName/", data: {
        "pin1": {"name": "Fan", "status": 1},
        "pin2": {"name": "study lamp", "status": 1},
        "pin3": {"name": "Light", "status": 0},
        "pin4": {"name": "AC", "status": 1},
        "pin5": {"name": "TV", "status": 1}
      });
      LocalStorage localStorage = LocalStorage();
      localStorage.setData("isInitialised", "true");
      localStorage.setData("deviceName", deviceName);
    } catch (e) {
      print(e);
    }
  }

  Future togglePin({required String pin}) async {
    try {
      LocalStorage localStorage = LocalStorage();
      String deviceName = await localStorage.getData("deviceName");
      if (deviceName.isEmpty) {
        Get.offAll(InitialiseView());
        return;
      }
      FirebaseController firebaseController = Get.put(FirebaseController());
      await firebaseController
          .updateData(dbPath: "$deviceName/$pin", data: {"status": 1});
    } catch (e) {
      print(e);
    }
  }

  Future getAllpins() async {
    LocalStorage localStorage = LocalStorage();
    String deviceName = await localStorage.getData("deviceName");
    if (deviceName.isEmpty) {
      Get.offAll(InitialiseView());
      return;
    }
    FirebaseController controller = Get.put(FirebaseController());
    update();
  }
}
