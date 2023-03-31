import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ShedulePage extends StatelessWidget {
  const ShedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
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
        ],
      )),
    );
  }
}
