import 'package:country_picker/country_picker.dart';
import 'package:firebase/app/modules/home/controller/Phone_controller.dart';
import 'package:firebase/app/modules/home/widget/custom_button.dart';
import 'package:firebase/app/modules/home/widget/custom_textfield.dart';
import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:firebase/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({super.key});
  final PhoneController phoneController = Get.put(PhoneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Text(
              "Phone No:- ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          true, // optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        print('Select country: ${country.displayName}');
                      },
                    );
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.blue,
                    child: Center(
                        child: Text("Num",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.white))),
                  ),
                ),
              ),
              Expanded(
                child: CustomTextField(
                    maxLength: 10,
                    type: TextInputType.number,
                    labelText: "Phone Number",
                    hintText: "Phone Number",
                    controller: phoneController.numberController),
              ),
            ],
          ),
          20.h,
          CustomButton(
            height: 60,
            width: 250,
            press: () {
              FireService()
                  .verifyPhoneNumber(phoneController.numberController.text);
            },
            text: "Submit",
            backColor: AppColor.blue,
            textColor: AppColor.white,
          )
        ],
      ),
    );
  }
}
