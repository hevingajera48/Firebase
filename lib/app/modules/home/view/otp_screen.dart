import 'dart:async';

import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  final String? phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  FireService fireService = FireService();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  // child: Image.asset(Constants.otpGifImage),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: "${widget.phoneNumber}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30,
                  ),
                  child:
                      // PinCodeTextField(
                      //   appContext: context,
                      //   pastedTextStyle: TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   length: 6,
                      //   obscureText: false,
                      //   animationType: AnimationType.fade,
                      //
                      //   validator: (v) {
                      //     if (v!.length < 3) {
                      //       return "I'm from validator";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   pinTheme: PinTheme(
                      //     shape: PinCodeFieldShape.box,
                      //     borderRadius: BorderRadius.circular(5),
                      //     fieldHeight: 50,
                      //     fieldWidth: 40,
                      //     activeFillColor: Colors.white,
                      //     inactiveColor: AppColor.blue,
                      //     selectedColor: AppColor.blue,
                      //   ),
                      //   cursorColor: Colors.black,
                      //   animationDuration: const Duration(milliseconds: 300),
                      //   enableActiveFill: true,
                      //   errorAnimationController: errorController,
                      //   controller: textEditingController,
                      //   keyboardType: TextInputType.number,
                      //   boxShadows: const [
                      //     BoxShadow(
                      //       offset: Offset(0, 1),
                      //       color: Colors.black12,
                      //       blurRadius: 10,
                      //     )
                      //   ],
                      //   onCompleted: (v) {
                      //     debugPrint("Completed");
                      //   },
                      //   // onTap: () {
                      //   //   print("Pressed");
                      //   // },
                      //   onChanged: (value) {
                      //     debugPrint(value);
                      //     setState(() {
                      //       currentText = value;
                      //     });
                      //   },
                      //   beforeTextPaste: (text) {
                      //     debugPrint("Allowing to paste $text");
                      //     return true;
                      //   },
                      // ),
                      PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 6,
                    autoDisposeControllers: false,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    cursorColor: AppColor.black,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      selectedColor: AppColor.blue,
                      inactiveColor: AppColor.blue,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                    appContext: context,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: AppColor.grey2,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => snackBar("OTP resend!!"),
                    child: const Text(
                      "RESEND",
                      style: TextStyle(
                        color: AppColor.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                decoration: BoxDecoration(
                    color: AppColor.grey2,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          offset: const Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: AppColor.blue,
                          offset: const Offset(-1, 2),
                          blurRadius: 5)
                    ]),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      fireService.verifyOtp(
                          smsCode: textEditingController.text);
                    },
                    child: Center(
                      child: Text(
                        "VERIFY".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextButton(
                      child: const Text("Clear",
                          style: TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      child: const Text("Set Text",
                          style: TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          textEditingController.text = "123456";
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
