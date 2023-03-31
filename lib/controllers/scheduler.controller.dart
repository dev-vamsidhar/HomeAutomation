import 'package:get/get.dart';
import 'package:homemate/controllers/deviceController.dart';

class SchedulerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  List schedules = [];
  Future<void> addSchedule(
      {required String roomName,
      required String appliance,
      required bool toOn,
      required String time}) async {
    schedules.add({
      "roomName": roomName,
      "appliance": appliance,
      "time": time,
      "toOn": toOn
    });
    schedules
        .sort((a, b) => int.parse(a['time']).compareTo(int.parse(b['time'])));
    update();
    DeviceController deviceController = Get.find();
    List keys = deviceController.appliances[roomName]!.keys.toList();
    String pinName = "";
    print("ok");
    for (var i = 0; i < keys.length; i++) {
      print(keys);
      if (deviceController.appliances[roomName]![keys[i]] == appliance) {
        pinName = keys[i];
        deviceController.devices[0]['pins'][keys[i]] = toOn ? "0" : "1";
        await Future.delayed(Duration(seconds: int.parse(time)));
        deviceController.toggleSwitch(
            deviceName: "ec21234",
            pins: deviceController.devices[0]['pins'],
            pinName: pinName,
            status: toOn ? "0" : "1");
        schedules.removeAt(0);
        update();
        return;
      }
    }

    update();
  }

  void deleteSchedule() {}
}
