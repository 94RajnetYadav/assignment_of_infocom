import 'package:assigment/main.dart';
import 'package:assigment/screen/auth/login_screen.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customDrawerDealer(
  BuildContext context,
) =>
    SafeArea(
      child: Drawer(
        child: Container(
          color: AllColor.white,
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              tileColor: AllColor.primaryColor,
              dense: true,
              title: GestureDetector(
                onTap: () {
                  // Navigator.of(context);
                  // Navigator.of(context).push(CupertinoPageRoute(
                  //     builder: (BuildContext context) => DealerProfile()));
                },
                child: Container(
                    width: screenWidth,
                    height: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/logo.png",
                        ),
                      ),
                      color: AllColor.white,
                    )),
              ),
              subtitle: Container(
                color: AllColor.white,
                width: screenWidth,
                height: screenHeight,
                child: Wrap(runSpacing: 0, children: [
                  Container(
                    height: screenWidth * 0.5,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: screenWidth * 0.06,
                        color: AllColor.black,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: AllColor.black),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => SignIn()));
                      },
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
