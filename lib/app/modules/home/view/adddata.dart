import 'package:firebase/app/modules/home/controller/firestore_controller.dart';
import 'package:firebase/app/modules/home/widget/custom_button.dart';
import 'package:firebase/app/modules/home/widget/custom_textfield.dart';
import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataScreen extends StatelessWidget {
  String? id;
  String? email;
  String? password;

  AddDataScreen({Key? key, this.id, this.email, this.password})
      : super(key: key);

  FirestoreControllers firestoreControllers = Get.put(FirestoreControllers());

  FireService fireService = FireService();

  @override
  Widget build(BuildContext context) {
    if (id != null && email != null && password != null) {
      firestoreControllers.email.text = email ?? "";
      firestoreControllers.password.text = password ?? "";
    }
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CustomTextField(
              labelText: "E-mail",
              hintText: "E-mail",
              controller: firestoreControllers.email,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              labelText: "password",
              hintText: "password",
              controller: firestoreControllers.password,
            ),
            SizedBox(
              height: 20,
            ),
            id != null
                ? CustomButton(
                    height: 50,
                    width: 150,
                    textColor: AppColor.white,
                    backColor: AppColor.blue,
                    text: "Update",
                    press: () {
                      fireService.updateDataFireStore(
                          id,
                          firestoreControllers.email.text,
                          firestoreControllers.password.text);
                      firestoreControllers.email.clear();
                      firestoreControllers.password.clear();
                      Get.back();
                    },

                  )
                : CustomButton(
                    height: 50,
                    width: 150,
                    textColor: AppColor.white,
                    backColor: AppColor.blue,
                    text: "Submit",
                    press: () {
                      final email = firestoreControllers.email.text;
                      final password = firestoreControllers.password.text;
                      fireService.setDataFireStore(email,password);
                      Get.back();

                    },
                  )
          ]),
        ),
      ),
    );
  }
}
