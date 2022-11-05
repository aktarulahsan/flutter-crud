import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_application/controller/home_controller.dart';
import 'package:test_flutter_application/entity/userModel.dart';
import 'package:test_flutter_application/utility/text_input_widget.dart';
import 'package:test_flutter_application/view/add_user.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;
  void _incrementCounter() {
    Get.to(AddUser());
    // setState(() {
    //   _counter++;
    // });
  }

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isUpdate.value= false;
          Get.to(AddUser());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("User Data"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),

          child: Obx(() => controller.userList.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.userList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserModel model= controller.userList[index];
                    return Container(
                      // margin: EdgeInsets.only(left: 10,right: 5),
                      height: 50,
                      child: Card(

                        child:Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Row(
                            children: [
                              Expanded(flex: 8, child: Text("${model.firstName} ${model.lastName}")),
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.edit(model);
                                    },
                                    child: Icon(Icons.edit),
                                  )),
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.deleteData(model.userId);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ),
                    );
                  })
              : Center(
                  child: Text("No data found , please add one"),
                ))),
    );
  }
}
