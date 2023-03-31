import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:homemate/views/home.view.dart';
import 'package:homemate/views/sheduler.view.dart';
import 'package:homemate/views/statistics.view.dart';

import '../controllers/deviceController.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> pages = [StatisticsPage(), HomePage(), ShedulePage()];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[index],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
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
                      index = 0;
                      setState(() {});
                    },
                    child: FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: index != 0
                          ? Color.fromARGB(255, 88, 88, 88)
                          : Colors.blue,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      index = 1;
                      setState(() {});
                    },
                    child: FaIcon(FontAwesomeIcons.house,
                        color: index != 1
                            ? Color.fromARGB(255, 88, 88, 88)
                            : Colors.blue),
                  ),
                  InkWell(
                    onTap: () {
                      index = 2;
                      setState(() {});
                    },
                    child: FaIcon(
                      FontAwesomeIcons.userLarge,
                      color: index != 2
                          ? Color.fromARGB(255, 88, 88, 88)
                          : Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
