import 'package:firebase/app/modules/home/controller/signin_controller.dart';
import 'package:firebase/app/modules/home/widget/custom_button.dart';
import 'package:firebase/app/modules/home/widget/custom_textfield.dart';
import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:firebase/constant/app_sizes.dart';
import 'package:firebase/constant/string_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SighinScreen extends StatelessWidget {
  SighinScreen({super.key});

  signincontroller Signincontroller = Get.put(signincontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Text(
                    StringConfig.create,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blue),
                  ),
                ),
                20.h,
                Text(
                  "Create an account so you can explore all the",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                5.h,
                Text(
                  "existing jobs",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black),
                ),
                10.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: "E-mail",
                    labelText: "E-mail",
                    controller: Signincontroller.emailController,
                  ),
                ),
                15.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: "Password",
                    labelText: "Password",
                    controller: Signincontroller.passController,
                  ),
                ),
                15.h,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    controller: Signincontroller.confirmPassword,
                  ),
                ),
                50.h,
                CustomButton(
                  height: 60,
                  width: 380,
                  textColor: AppColor.white,
                  backColor: AppColor.blue,
                  text: "Sign Up ",
                  press: () {
                    FireService().SignupAuth(
                        Signincontroller.emailController.text,
                        Signincontroller.passController.text);
                    Signincontroller.update();
                  },
                ),
                50.h,
                Text(
                  "Already have an account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ),
    );
  }
}
