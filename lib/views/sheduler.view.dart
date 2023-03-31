import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/deviceController.dart';
import 'package:homemate/controllers/scheduler.controller.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  SchedulerController scheduleController = Get.put(SchedulerController());

  DeviceController deviceController = Get.put(DeviceController());

  String room = "";
  String appliance = "";
  TextEditingController timeController = TextEditingController();
  bool toOn = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<SchedulerController>(builder: (context) {
        return Column(
          children: [
            Container(
              height: 80,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 5,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: SizedBox(
                width: Get.width,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.barsStaggered,
                            color: Color.fromARGB(255, 100, 100, 100),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Routines/Schedules",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 100, 100, 100),
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: scheduleController.schedules.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              scheduleController.schedules[index]["time"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              scheduleController.schedules[index]["toOn"]
                                  ? "Turn On"
                                  : "Turn Off",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              scheduleController.schedules[index]["roomName"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              scheduleController.schedules[index]["appliance"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
            InkWell(
              onTap: () {
                room = deviceController.devices
                    .map<String>((e) => e["room"])
                    .toList()[0];
                appliance = deviceController.appliances[room]!.values
                    .toList()
                    .map<String>((e) => e.toString())
                    .toList()[0];
                Get.defaultDialog(
                    content: GetBuilder<SchedulerController>(builder: (_) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                value: room,
                                iconSize: 0,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                underline: SizedBox(),
                                onChanged: (val) {
                                  room = val!;
                                  scheduleController.update();
                                  setState(() {});
                                },
                                items: deviceController.devices
                                    .map<String>((e) => e["room"])
                                    .toList()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                value: appliance,
                                iconSize: 0,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                underline: SizedBox(),
                                onChanged: (val) {
                                  appliance = val!;
                                  scheduleController.update();
                                  setState(() {});
                                },
                                items: deviceController.appliances[room]!.values
                                    .toList()
                                    .map<String>((e) => e.toString())
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                value: toOn ? "on" : "off",
                                iconSize: 0,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                underline: SizedBox(),
                                onChanged: (val) {
                                  toOn = val == "on";
                                  scheduleController.update();
                                  setState(() {});
                                },
                                items: [
                                  "on",
                                  "off"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter the time in seconds"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          scheduleController.addSchedule(
                              roomName: room,
                              appliance: appliance,
                              toOn: toOn,
                              time: timeController.text);
                          Get.back();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "Add Schedule",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  )),
                ),
              ),
            )
          ],
        );
      })),
    );
  }
}
