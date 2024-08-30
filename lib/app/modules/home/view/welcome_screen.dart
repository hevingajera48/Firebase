import 'package:firebase/app/modules/home/view/login_screen.dart';
import 'package:firebase/app/modules/home/view/signin_screen.dart';
import 'package:firebase/app/modules/home/widget/custom_button.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:firebase/constant/app_image.dart';
import 'package:firebase/constant/app_sizes.dart';
import 'package:firebase/constant/string_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
        children: [
            Image(
              image: AssetImage(AppImages.logo),
            ),
            Center(
                child: Text(
              StringConfig.discover,
              style: TextStyle(
                  color: AppColor.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            )),
            20.h,
            Center(
                child: Text(
              StringConfig.dream,
              style: TextStyle(
                  color: AppColor.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            )),
            30.h,
            Text(
              StringConfig.explore,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Center(
                child: Text(
              StringConfig.interest,
              style: TextStyle(
                fontSize: 14,
              ),
            )),
            60.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  height: 50,
                  width: 150,
                  text: "log in",
                  backColor: AppColor.blue,
                  textColor: Colors.white,
                  press: () {
                    Get.off(LoginScreen());
                  },
                ),
                CustomButton(
                  width: 150,
                  height: 50,
                  text: "register",
                  backColor: Colors.white,
                  textColor: Colors.black,
                  press: () {
                    Get.off(SighinScreen());
                  },
                ),
              ],
            ),

        ],
      ),
          )),
    );
  }
}
