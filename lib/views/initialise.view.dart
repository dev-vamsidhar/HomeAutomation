import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:homemate/controllers/automation.controller.dart';
import 'package:homemate/controllers/firebase.controller.dart';

class InitialiseView extends StatelessWidget {
  const InitialiseView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ActionChip(
                  label: Text("INitialiase"),
                  onPressed: () async{
                    AutomationController controller =
                        Get.put(AutomationController());
                   await controller.intialiseAllpins(deviceName: "ec21234");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
