import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:test_flutter_application/db/Dbhelper.dart';
import 'package:test_flutter_application/entity/userModel.dart';
import 'package:test_flutter_application/view/add_user.dart';

class HomeController extends GetxController {
  final TextEditingController firstNameTextCont = TextEditingController();
  final TextEditingController lastNameTextCont = TextEditingController();

  final TextEditingController streeTextCont = TextEditingController();
  final TextEditingController cityTextCont = TextEditingController();
  final TextEditingController stateTextCont = TextEditingController();
  final TextEditingController zipTextCont = TextEditingController();
  var userList = <UserModel>[].obs;
  var address = Address().obs;
  var isUpdate = false.obs;
  var userModel = UserModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  void getUser() {
    DBHelper.getAllUser().then((value) {
      userList.value = userModelPostFromJson(json.encode(value));

    });
  }
  void getAddress(userId){
      DBHelper.getAddressByUserId( userId).then((value) {
         address.value = Address.fromJson(value[0]);
      });
  }

  void edit(UserModel model){
    isUpdate.value= true;
    userModel.value = model;
     firstNameTextCont.text= model.firstName!;
     lastNameTextCont.text=model.lastName!;
     DBHelper.getAddressByUserId(model.userId).then((value) {
     if(value.isNotEmpty){
       address.value = Address.fromJson(value[0]);

       streeTextCont.text=address.value.stree!;
       cityTextCont.text =address.value.city! ;
       stateTextCont.text= address.value.state!;
       zipTextCont.text=address.value.zip.toString() ;
     }
     });
  Get.to(AddUser());
  }
void deleteData(userid){
  DBHelper.deleteAddress(userid);
    DBHelper.deleteUser(userid);

getUser();
}

  Future<void> dataSave() async {
    UserModel model = UserModel();

    model.firstName = firstNameTextCont.text??"";
    model.lastName = lastNameTextCont.text??"";
    Address address = Address();

    address.stree = streeTextCont.text??"";
    address.city = cityTextCont.text??"";
    address.state = stateTextCont.text??"";
    address.zip = int.parse(zipTextCont.text);
    // model.address = address;

    await DBHelper.insertUser(model).then((value) async {
      if (value != 0) {
          address.userId = value;
        await  DBHelper.insertAddress(address);

        getUser();
          clear();
          Get.back();
      } else {}
    });
  }
  Future<void> dataUpdate() async {
    UserModel model = UserModel();
    model.userId = userModel.value.userId;
    model.firstName = firstNameTextCont.text??"";
    model.lastName = lastNameTextCont.text??"";
    Address addressdata = Address();
    addressdata.addresId = address.value.addresId;
    addressdata.stree = streeTextCont.text??"";
    addressdata.city = cityTextCont.text??"";
    addressdata.state = stateTextCont.text??"";
    addressdata.zip = int.parse(zipTextCont.text);
    // model.address = address;

    await DBHelper.updateUser(model,model.userId).then((value) async {
      if (value != 0) {
        // address.userId = value;
        await  DBHelper.updateAddress(addressdata, addressdata.addresId);

        getUser();
        clear();
        Get.back();
      } else {}
    });
  }
  void clear(){
    firstNameTextCont.text= "";
    lastNameTextCont.text="";
        streeTextCont.text="";
        cityTextCont.text ="";
        stateTextCont.text= "";
        zipTextCont.text="";
  }
}
