import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/deviceController.dart';
import 'package:homemate/views/devices/adddevice.view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  int currentRoomIndex = 0;
  @override
  Widget build(BuildContext context) {
    DeviceController controller = Get.put(DeviceController(), permanent: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<DeviceController>(builder: (_) {
          return Stack(
            children: [
              Column(
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
                                  "Home",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 100, 100, 100),
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                              )),
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.devices.length + 1,
                          itemBuilder: (context, index) {
                            return index != controller.devices.length
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: InkWell(
                                      onTap: () {
                                        currentRoomIndex = index;
                                        controller.update();
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              controller.devices[index]["room"],
                                              style: TextStyle(
                                                  color:
                                                      index == currentRoomIndex
                                                          ? Colors.black
                                                          : Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      index == 0 ? 17.5 : 16),
                                            ),
                                            SizedBox(height: 7),
                                            index == currentRoomIndex
                                                ? Container(
                                                    height: 5,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      Get.to(AddDevice());
                                    },
                                    child: Container(
                                      height: 10,
                                      child: Text(
                                        "+ Add Device",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                          }),
                    ),
                  ),
                  // ___________________________
                  Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.devices.isNotEmpty
                            ? controller
                                .devices[currentRoomIndex]["appliances"].length
                            : 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return iotItemWidget(false,
                              name: controller.devices[currentRoomIndex]
                                      ["appliances"][
                                  controller
                                      .devices[currentRoomIndex]["appliances"]
                                      .keys
                                      .toList()[index]],
                              pin: controller
                                  .devices[currentRoomIndex]["appliances"].keys
                                  .toList()[index],
                              value: controller.devices[currentRoomIndex]
                                      ["pins"]
                                      [controller.devices[currentRoomIndex]["appliances"].keys.toList()[index]]
                                  .toString(),
                              deviceName: controller.devices[currentRoomIndex]['name'],
                              pins: controller.devices[currentRoomIndex]['pins'],
                              pinName: controller.devices[currentRoomIndex]["appliances"].keys.toList()[index]);
                        }),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: Colors.black,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          DeviceController().getDevices();
                        },
                        child: FaIcon(
                          FontAwesomeIcons.chartSimple,
                          color: Color.fromARGB(255, 88, 88, 88),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: FaIcon(FontAwesomeIcons.house,
                            color: Color.fromARGB(255, 88, 88, 88)),
                      ),
                      InkWell(
                        onTap: () {},
                        child: FaIcon(
                          FontAwesomeIcons.userLarge,
                          color: Color.fromARGB(255, 88, 88, 88),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }), // White background color
      ),
    );
  }

  Widget iotItemWidget(bool status,
      {required String name,
      required String pin,
      required String value,
      required String deviceName,
      required Map<String, dynamic> pins,
      required String pinName}) {
    status = value == "0" ? false : true;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(
                2,
                2,
              ),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 0, 104, 189),
              Color.fromARGB(255, 225, 224, 224),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Switch",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: FlutterSwitch(
                        activeToggleColor: Colors.green,
                        inactiveToggleColor: Colors.red,
                        padding: 2,
                        inactiveColor: Colors.white,
                        activeColor: Colors.white,
                        width: 40,
                        height: 20,
                        value: status,
                        onToggle: (valv) {
                          status = valv;
                          pins[pinName] = status ? "1" : "0";
                          Get.find<DeviceController>().toggleSwitch(
                              deviceName: deviceName,
                              pins: pins,
                              pinName: pinName,
                              status: status ? "1" : "0");
                        }),
                  )
                ],
              ),
              FaIcon(
                name.toLowerCase() == "light"
                    ? FontAwesomeIcons.lightbulb
                    : name.toLowerCase() == "fan"
                        ? FontAwesomeIcons.fan
                        : name.toLowerCase() == "ac"
                            ? FontAwesomeIcons.snowflake
                            : name.toLowerCase() == "tv"
                                ? FontAwesomeIcons.tv
                                : FontAwesomeIcons.plug,
                color: Colors.white,
                size: 29,
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
