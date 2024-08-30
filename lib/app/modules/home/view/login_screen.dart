import 'package:firebase/app/modules/home/controller/login_controller.dart';
import 'package:firebase/app/modules/home/widget/custom_button.dart';
import 'package:firebase/app/modules/home/widget/custom_textfield.dart';
import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:firebase/constant/app_image.dart';
import 'package:firebase/constant/app_sizes.dart';
import 'package:firebase/constant/string_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController loginController = Get.put(LoginController());
  FireService fireService = FireService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Center(
            child: Text(
              StringConfig.login,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blue),
            ),
          ),
        ),
        20.h,
        Text(
          StringConfig.welcome,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
        5.h,
        Text(
          StringConfig.been,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
        10.h,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            hintText: "E-mail",
            labelText: "E-mail",
            controller: loginController.emailController,
          ),
        ),
        20.h,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            hintText: "Password",
            labelText: "Password",
            controller: loginController.passwordController,
          ),
        ),
        30.h,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(StringConfig.forgot,
                style: const TextStyle(
                    color: AppColor.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        30.h,
        CustomButton(
          height: 60,
          width: 350,
          text: "Sign in",
          backColor: AppColor.blue,
          textColor: AppColor.white,
          press: () {
            FireService().LoginAuth(loginController.emailController.text,
                loginController.passwordController.text);
          },
        ),
        30.h,
        Text(
          StringConfig.create,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        30.h,
        Text(
          StringConfig.or,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.blue),
        ),
        ElevatedButton(
          onPressed: () {
            fireService.googleSignInLogin();
          },
          child: ImageIcon(
            AssetImage(AppImages.gLogo),
          ),
        )
      ]),
    ));
  }
}
