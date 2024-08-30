import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/modules/home/controller/Phone_controller.dart';
import 'package:firebase/app/modules/home/controller/firestore_controller.dart';
import 'package:firebase/app/modules/home/view/firestore.dart';
import 'package:firebase/app/modules/home/view/login_screen.dart';
import 'package:firebase/app/modules/home/view/otp_screen.dart';
import 'package:firebase/app/modules/home/view/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireService {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String verification = "";
  PhoneController phoneController = PhoneController();
  FirestoreControllers firestoreControllers = Get.put(FirestoreControllers());

  get auth => null;
  SignupAuth(email, password) async {
    print(email + password);
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Get.off(LoginScreen());
      }
    } catch (e) {
      print("Error:---$e");
    }
  }

  LoginAuth(email, password) async {
    print(email + password);
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        Get.off(() => WelcomeScreen());
      }
    } catch (e) {
      print("Error:---$e");
    }
  }

  verifyPhoneNumber(phoneNumber) async {
    try {
      await firebaseAuth
          .verifyPhoneNumber(
            phoneNumber: "+91${phoneNumber}",
            verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
            verificationFailed: (FirebaseAuthException error) {},
            codeSent: (String verificationId, int? forceResendingToken) {
              phoneController.verification = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          )
          .then((value) => Get.off(OtpScreen(
                phoneNumber: phoneNumber,
              )));
    } catch (e) {
      print("Error:-$e");
    }
  }

  verifyOtp({smsCode}) async {
    try {
      print("===>${phoneController.verification}");
      final credential = PhoneAuthProvider.credential(
          verificationId: phoneController.verification, smsCode: smsCode);
      final user = await firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        print(user);
        Get.off(WelcomeScreen());
      }
    } catch (e, st) {
      print("Error:-${e}\nStack:-${st}");
    }
  }

  // String? _verificationId;
  googleSignInLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
      final user = await firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        print('Signed in with Google: ${user.user!.photoURL}');
        Get.offAll(WelcomeScreen());
      } else {
        print('Failed to sign in with Google');
      }
    } catch (e) {}
  }

  setDataFireStore(email, password) async {
    try {
      String docId = firebaseFirestore.collection('user').doc().id;

      await firebaseFirestore.collection('user').doc(docId).set(
          {'email': email, 'password': password, 'did': docId}).then((value) {
        Get.snackbar("Success", "Data added sucessfully",
            backgroundColor: Colors.green.withOpacity(.4));
        return Get.to(FirestoreScreen());
      });
    } catch (e) {
      print("Error:-$e");
    }
  }

  updateDataFireStore(id, email, password) async {
    try {
      await firebaseFirestore.collection('user').doc(id).update(
          {'email': email, 'password': password, 'did': id}).then((value) {
        Get.snackbar("Success", "Data upadted sucessfully",
            backgroundColor: Colors.green.withOpacity(.4));
        return Get.to(FirestoreScreen());
      });
    } catch (e) {
      print("Error:-$e");
    }
  }

  DeleteDataFireStore(id) async {
    try {
      await firebaseFirestore.collection('user').doc(id).delete().then((value) {
        Get.snackbar("Success", "Data Deletee sucessfully",
            backgroundColor: Colors.green.withOpacity(.4));
      });
    } catch (e) {
      print("Error:-$e");
    }
  }
}
