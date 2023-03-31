import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/firebase.controller.dart';
import 'package:homemate/views/devices/devices.view.dart';
import 'package:homemate/views/home.view.dart';
import 'package:homemate/views/navigation.view.dart';

import 'localStorage.controller.dart';

class DeviceController extends GetxController {
  @override
  void onInit() {
    getDevices();
    super.onInit();
  }

  List<Map<String, dynamic>> devices = [];
  Map<String, Map<String, dynamic>> appliances = {};

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
          "pins": value["pins"]
        });
        appliances[value['name']] = value["appliances"];
      });
      print(devices);
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
    Map<String, String> pins = {};
    for (int i = 0; i < appliances.length; i++) {
      appliancedetails.addAll({
        "pin${appliances[i]["pin"].toString()}": "${appliances[i]["name"]}",
      });
      pins["pin${appliances[i]["pin"].toString()}"] = "0";
    }
    await controller.updateData(dbPath: "/users/$username/devices", data: {
      "$deviceName": {
        "name": roomName,
        "passcode": passCode,
        "appliances": appliancedetails,
        "pins": pins
      }
    });
    await controller.updateData(dbPath: "/devices/$deviceName", data: pins);
    await getDevices();
    Get.offAll(Navigation());
  }

  Future toggleSwitch(
      {required String deviceName,
      required Map<String, dynamic> pins,
      required String pinName,
      required String status}) async {
    EasyLoading.show(status: status == "0" ? "turning on" : "Turning off");
    String username = await LocalStorage.getData("username");
    if (username.isEmpty) {
      username = "vamsubala1";
    }
    await FirebaseController().updateData(
        dbPath: "/users/$username/devices/$deviceName", data: {"pins": pins});
    await FirebaseController()
        .updateData(dbPath: "devices/$deviceName/", data: {pinName: status});
    await getDevices();
    EasyLoading.dismiss();
  }
}
