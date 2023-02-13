import 'dart:convert';
import 'dart:developer';

import 'package:assigment/commonApi/commpnApi.dart';
import 'package:assigment/commonLoader/commonLoader.dart';
import 'package:assigment/main.dart';
import 'package:assigment/screen/View_Screen/customdrawer.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _loading = false;
  List listStoreData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
        appBar: AppBar(title: Text("DashBoard")),
        drawer: customDrawerDealer(context),
        body: LoadingOverlay(
          isLoading: _loading,
          opacity: 0.5,
          color: AllColor.black,
          progressIndicator: commonLoader(),
          child: Container(
            color: AllColor.greyColor.withOpacity(0.15),
            width: screenWidth,
            height: screenHeight,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: listStoreData.length,
                        itemBuilder: (BuildContext, index) {
                          return ContactItem(listStoreData[index]);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ContactItem(Map<String, dynamic> data

      // String name, String phoneNumber
      ) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02, vertical: screenWidth * 0.02),
        width: screenWidth,
        // color: AllColor.white,
        // height: screenWidth * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: AllColor.blueGrey, width: 2),
          color: AllColor.white,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth * 0.03),
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(data["avatar"])),
                borderRadius: BorderRadius.circular(10000),
                border: Border.all(color: AllColor.blueGrey, width: 2),
                color: AllColor.white,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: " + data["first_name"] + " " + data["last_name"]),
                  Text("Email: " + data["email"]),
                  Text("ID: " + data["id"].toString()),
                  Container(
                      width: screenWidth * 0.35,
                      height: screenWidth * 0.08,
                      child: ElevatedButton(
                          onPressed: () {
                            log("Firebase");

                            final user = User(
                              name: data["first_name"].toString(),
                              lastname: data["last_name"].toString(),
                              email: data["email"].toString(),
                            );
                            log(user.name);
                            createusername(user);
                          },
                          child: const Text("FireBase Store"))),
                ],
              ),
            )
          ],
        ));
  }

  Future createusername(User user) async {
    final docUser = FirebaseFirestore.instance.collection("user").doc();

    user.id = docUser.id;
    log(user.id);
    final json = user.toJson();
    await docUser.set(json);
  }

  listData() {
    setState(() {
      _loading = true;
    });
    commonApigetRequest(
      "https://reqres.in/api/users?page=2",
      context,
    ).then((response) {
      if (response == null) {
        print("Server Error");
      } else {
        Map<String, dynamic> jsonData = jsonDecode(response);
        if (jsonData["data"] != null) {
          listStoreData = jsonData["data"];
          setState(() {
            _loading = false;
          });

          log("fff=+${listStoreData}");
        }
      }
    });
  }

  Future<bool> handleWillPop(BuildContext context) async {
    commonAlertDialogForBackPressToClose(context);

    return false;
  }

  commonAlertDialogForBackPressToClose(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 0.0,
                  backgroundColor: AllColor.white,
                  title: Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: Container(
                          child: Text(
                        "Assignment",
                        style: TextStyle(color: AllColor.black),
                      ))),
                  children: [
                    // SizedBox(
                    //   height: screenWidth * 0.01,
                    // ),
                    Container(
                        // color: AllColor.blue,
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.exit_to_app,
                        )),
                    SizedBox(
                      height: screenWidth * 0.02,
                    ),
                    Container(
                        width: screenWidth,
                        alignment: Alignment.center,
                        child: Text(
                          "Are you sure you want to close this App?",
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      height: screenWidth * 0.02,
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                                width: screenWidth < 450
                                    ? screenWidth * 0.3
                                    : screenWidth * 0.25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"))),
                          ),
                          Center(
                            child: Container(
                                width: screenWidth < 450
                                    ? screenWidth * 0.3
                                    : screenWidth * 0.25,

                                //screenWidth * 0.3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: Text("Yes"))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenWidth * 0.03,
                    ),
                  ]),
            ));
  }
}

class User {
  String id = '';
  final String name;
  final String lastname;
  final String email;

  User({
    this.id = '',
    required this.name,
    required this.lastname,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
      };
}
