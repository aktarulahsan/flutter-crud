import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_flutter_application/controller/home_controller.dart';
import 'package:test_flutter_application/utility/text_input_widget.dart';

class AddUser extends StatelessWidget {
  AddUser({super.key});
  // final controller = Get.put(HomeController());
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add user"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextInputWidget(
              controller: controller.firstNameTextCont,
              hint: "Mr. xxx",
              leble: "First name",
              type: TextInputType.text,
            ),
            SizedBox(
              height: 5,
            ),
            TextInputWidget(
              controller: controller.lastNameTextCont,
              hint: "Mr. xxx",
              leble: "Last name",
              type: TextInputType.text,
            ),
            SizedBox(
              height: 5,
            ),
            TextInputWidget(
              controller: controller.streeTextCont,
              hint: "mirpur",
              leble: "stree name",
              type: TextInputType.text,
            ),
            SizedBox(
              height: 5,
            ),
            TextInputWidget(
              controller: controller.cityTextCont,
              hint: "Dhaka",
              leble: "city name",
              type: TextInputType.text,
            ),
            SizedBox(
              height: 5,
            ),
            TextInputWidget(
              controller: controller.stateTextCont,
              hint: "dhaka",
              leble: "state name",
              type: TextInputType.text,
            ),
            SizedBox(
              height: 5,
            ),
            TextInputWidget(
              controller: controller.zipTextCont,
              hint: "0023",
              leble: "zip  Code",
              type: TextInputType.text,
            ),
            Obx(() => controller.isUpdate==true?TextButton(
                onPressed: () {
                  controller.dataSave();
                },
                child: Text("Update")):TextButton(
                onPressed: () {
                  controller.dataSave();
                },
                child: Text("Submit")))

          ],
        ),
      ),
    );
  }
}
