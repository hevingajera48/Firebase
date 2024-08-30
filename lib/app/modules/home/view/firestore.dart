import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/modules/home/controller/firestore_controller.dart';
import 'package:firebase/app/modules/home/view/adddata.dart';
import 'package:firebase/app/modules/service/Fire_Service.dart';
import 'package:firebase/constant/app_color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class FirestoreScreen extends StatelessWidget {
  FirestoreScreen({Key? key}) : super(key: key);

  FirestoreControllers firestoreController = Get.put(FirestoreControllers());

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FireService fireService = FireService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("iudScreen"))),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddDataScreen());
          },
          child: Icon(Icons.add)),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firebaseFirestore.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == true) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.toString().isNotEmpty) {
            final data = snapshot.data?.docs ?? [];
            print("Data:-${snapshot.data!.docs.length}");
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                bool _isSwiped = false;
                return SwipeableTile(
                  color: Colors.transparent,
                  swipeThreshold: 0.2,
                  direction: SwipeDirection.horizontal,
                  onSwiped: (direction) {
                    if (direction == SwipeDirection.startToEnd && _isSwiped) {
                      Get.to(AddDataScreen(
                        id: data[index]['did'],
                        email: data[index]['email'],
                        password: data[index]['password'],
                      ));
                    } else if (direction == SwipeDirection.endToStart) {
                      fireService.DeleteDataFireStore(data[index]['did']);
                      Get.snackbar("success", "data deleted successfully");
                    }
                  },
                  key: UniqueKey(),
                  backgroundBuilder: (context, direction, progress) {
                    if (direction == SwipeDirection.endToStart) {
                      return Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                      );
                    } else if (direction == SwipeDirection.startToEnd) {
                      _isSwiped = true;
                      return Container(
                        color: Colors.blue,
                        child: Icon(Icons.edit),
                      );
                    }

                    return Container();
                  },
                  child: Card(
                      child: ListTile(
                    title: Text("${data[index]['email']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("${data[index]['password']}"),
                      ],
                    ),
                    leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Text("${index + 1}")),
                  )),
                );
              },
            );
          } else {
            return const Text("No data found");
          }
        },
      ),

      // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //   stream: firebaseFirestore.collection('user').snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == true) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasData && snapshot.data!.toString().isNotEmpty) {
      //       final data = snapshot.data?.docs ?? [];
      //       print("Data:-${snapshot.data!.docs.length}");
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (context, index) {
      //           return Card(
      //               child: ListTile(
      //             title: Text("${data[index]['email']}"),
      //             subtitle: Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: [
      //                 Text("${data[index]['password']}"),
      //               ],
      //             ),
      //             leading: CircleAvatar(
      //                 backgroundColor: Colors.amber,
      //                 child: Text("${index + 1}")),
      //           ));
      //         },
      //       );
      //     } else {
      //       return const Text("No data found");
      //     }
      //   },
      // ),

      // ListView.builder(
      //   itemCount: 5,
      //   itemBuilder: (context, index) {
      //     return const Card(
      //       child: ListTile(
      //         title: Text("Email"),
      //         subtitle: Text("password"),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
