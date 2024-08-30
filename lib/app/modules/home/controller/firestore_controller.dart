import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreControllers extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxList data = [].obs;
  RxMap value = {}.obs;

}
