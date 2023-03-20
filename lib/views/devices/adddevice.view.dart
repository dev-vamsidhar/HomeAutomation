import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/deviceController.dart';

class AddDevice extends StatefulWidget {
  AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  @override
  DeviceController controller = Get.find();
  TextEditingController roomName = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController passcode = TextEditingController();
  List<String> pins = ["Pin 1", "Pin 2", "Pin 3", "Pin 4", "Pin 5"];
  List<Map<String, String>> selectedPins = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add device",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextFeild(
                      editingController: deviceId, hint: "Device Id"),
                  customTextFeild(
                      editingController: passcode, hint: "Passcode"),
                  customTextFeild(
                      editingController: roomName, hint: "Room Name"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0) + EdgeInsets.only(top: 10),
                        child: Text(
                          "Appliances:-",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0) + EdgeInsets.only(top: 10),
                        child: IconButton(
                            onPressed: () {
                              addAppliance();
                            },
                            icon: Icon(Icons.add)),
                      )
                    ],
                  ),
                  Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selectedPins.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Pin No -${selectedPins[index]["pin"].toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                                Text(
                                  "${selectedPins[index]["name"].toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    controller.addDevice(
                        deviceName: deviceId.text,
                        roomName: roomName.text,
                        appliances: selectedPins,
                        passCode: passcode.text);
                  },
                  child: Text(
                    "Add Device",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  addAppliance() {
    TextEditingController pin = TextEditingController();
    TextEditingController name = TextEditingController();
    Get.defaultDialog(
        title: "Add Appliance",
        content: Container(
          child: Column(
            children: [
              customTextFeild(
                  editingController: pin,
                  hint: "Pin no. (Should be less than 6)",
                  type: TextInputType.number),
              customTextFeild(editingController: name, hint: "Appliance Name"),
            ],
          ),
        ),
        onConfirm: () {
          if (int.parse(pin.text) < 6) {
            if (name.text.isNotEmpty) {
              for (var i = 0; i < selectedPins.length; i++) {
                if (pin.text == selectedPins[i]["pin"]) {
                  EasyLoading.showToast("Pin already selected");
                  return;
                }
              }
              selectedPins.add({"pin": pin.text, "name": name.text});
              setState(() {});
              Get.back();
            } else {
              EasyLoading.showToast("Name should not be empty");
            }
          } else {
            EasyLoading.showToast("Pin should be less than 6");
          }
        });
  }

  Widget customTextFeild(
      {required TextEditingController editingController,
      required String hint,
      TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          controller: editingController,
          keyboardType: type,
          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(
                start: 10, end: 10, top: 10, bottom: 10),
            border: OutlineInputBorder(),
            label: Text(hint),
          ),
        ),
      ),
    );
  }
}
