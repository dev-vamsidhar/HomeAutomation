import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> rooms = [
      "Living Room",
      "Kitchen",
      "Bedroom",
      "Master Bedroom",
      "PentHouse"
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      rooms[index],
                                      style: TextStyle(
                                          color: index == 0
                                              ? Colors.black
                                              : Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: index == 0 ? 17.5 : 16),
                                    ),
                                    SizedBox(height: 7),
                                    index == 0
                                        ? Container(
                                            height: 5,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        : Container()
                                  ],
                                ),
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
                      itemCount: 7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? iotItemWidget(false)
                            : iotItemWidget(true);
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
                    FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: Color.fromARGB(255, 88, 88, 88),
                    ),
                    FaIcon(FontAwesomeIcons.house,
                        color: Color.fromARGB(255, 88, 88, 88)),
                    FaIcon(
                      FontAwesomeIcons.userLarge,
                      color: Color.fromARGB(255, 88, 88, 88),
                    )
                  ],
                ),
              ),
            )
          ],
        ), // White background color
      ),
    );
  }

  Widget iotItemWidget(bool status) {
    return !status
        ? Padding(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
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
                              value: true,
                              onToggle: (val) {}),
                        )
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.lightbulb,
                      color: Colors.white,
                      size: 29,
                    ),
                    Text(
                      "Main Light",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Switch",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        RotatedBox(
                          quarterTurns: 3,
                          child: FlutterSwitch(
                              activeToggleColor: Colors.green,
                              inactiveToggleColor: Colors.red,
                              padding: 2,
                              inactiveColor: Color.fromARGB(255, 219, 216, 216),
                              activeColor: Color.fromARGB(255, 202, 202, 202),
                              width: 40,
                              height: 20,
                              value: false,
                              onToggle: (val) {}),
                        )
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.lightbulb,
                      color: Colors.black,
                      size: 29,
                    ),
                    Text(
                      "Main Light",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
