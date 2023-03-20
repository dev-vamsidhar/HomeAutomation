import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/firebase.controller.dart';
import 'package:homemate/views/devices/devices.view.dart';
import 'package:homemate/views/home.view.dart';

import 'localStorage.controller.dart';

class DeviceController extends GetxController {
  @override
  void onInit() {
    getDevices();
    super.onInit();
  }

  List<Map<String, dynamic>> devices = [];
  Future getDevices() async {
    FirebaseController controller = Get.put(FirebaseController());
    String username = await LocalStorage.getData("username");
    if (username.isEmpty) {
      username = "vamsubala1";
    }
    DataSnapshot snapshot =
        await controller.getData(dbPath: "users/$username/devices");
    if (snapshot.value == null) {
      Get.offAll(DeviceManager());
      return;
    } else {
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value));
      devices = [];
      data.forEach((key, value) {
        devices.add({
          "name": key,
          "room": value["name"],
          "appliances": value["appliances"],
        });
      });
      print(devices);
      ;
      update();
    }
  }

  Future addDevice(
      {required String deviceName,
      required String roomName,
      required String passCode,
      required List<Map<String, String>> appliances}) async {
    FirebaseController controller = FirebaseController();
    String username = await LocalStorage.getData("username");
    if (username.isEmpty) {
      username = "vamsubala1";
    }
    Map<String, String> appliancedetails = {};
    for (int i = 0; i < appliances.length; i++) {
      appliancedetails.addAll({
        "pin${appliances[i]["pin"].toString()}": "${appliances[i]["name"]}",
      });
    }
    await controller.updateData(dbPath: "/users/$username/devices", data: {
      "$deviceName": {
        "name": roomName,
        "passcode": passCode,
        "appliances": appliancedetails,
      }
    });
    await getDevices();
    Get.offAll(HomePage());
  }
}
