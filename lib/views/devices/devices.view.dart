import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/deviceController.dart';
import 'package:homemate/views/devices/adddevice.view.dart';

class DeviceManager extends StatelessWidget {
  const DeviceManager({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Device Manager",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GetBuilder<DeviceController>(builder: (_) {
        return controller.devices.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "No devices found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          Get.to(AddDevice());
                        },
                        child: Text(
                          "Add Device",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container();
      }),
    );
  }
}
