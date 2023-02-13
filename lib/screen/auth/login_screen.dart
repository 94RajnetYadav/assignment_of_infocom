import 'dart:convert';
import 'dart:developer';

import 'package:assigment/commonApi/commpnApi.dart';
import 'package:assigment/main.dart';
import 'package:assigment/screen/View_Screen/dashboard.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:assigment/utils/allString/allString.dart';
import 'package:assigment/utils/commonButton/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //TODO: App Declaration Here
  bool _loading = false;
  String errortextvalidate = "";
  String errorTextuser = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _usernameTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  bool obscureText = true;
  bool loading = false;
  bool result = false;
  bool uservalue10digit = false;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            child: SingleChildScrollView(
                child: Container(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.35,
                    height: screenWidth * 0.35,
                    alignment: Alignment.center,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: screenWidth * 0.22,
                            width: screenWidth * 0.22,
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.05,
                      bottom: screenHeight * 0.02,
                    ),
                  ),
                  SizedBox(
                    height: screenWidth * 0.3,
                  ),
                  customTextField(
                      AllString.username,
                      _usernameTextEditingController,
                      FontAwesomeIcons.userAlt,
                      100,
                      TextInputAction.next,
                      TextInputType.text, onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        uservalue10digit = false;
                        errorTextuser = "Please type your user name";
                      });
                    } else if (value.length < 10) {
                      setState(() {
                        uservalue10digit = false;
                        errorTextuser = "User name must be 10 digit";
                      });
                    } else {
                      setState(() {
                        uservalue10digit = true;
                        errorTextuser = "";
                      });
                    }
                  }),
                  SizedBox(
                    height: screenWidth * 0.03,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.008),
                    child: TextFormField(
                      onChanged: (String? value) {
                        if (value!.isEmpty) {
                          setState(() {
                            errortextvalidate = "";
                          });
                        } else if (value.length < 7) {
                          setState(() {
                            result = false;
                            errortextvalidate = " Password must be 7 digit";
                          });
                        } else {
                          result = validatePassword(value);
                          if (result == false) {
                            setState(() {
                              errortextvalidate =
                                  " Password should contain Capital, small letter & Number & Special";
                            });
                          } else {
                            setState(() {
                              errortextvalidate = "";
                            });
                          }
                        }
                      },
                      controller: _passwordTextEditingController,
                      obscureText: obscureText,
                      textInputAction: TextInputAction.done,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        errorText: errortextvalidate.isEmpty
                            ? null
                            : errortextvalidate,
                        prefixIcon: Icon(FontAwesomeIcons.lock,
                            size: screenWidth * 0.05,
                            color: AllColor.primaryColor),
                        suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash),
                            onPressed: () {
                              obscureText = !obscureText;
                              setState(() {});
                            }),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                                color: AllColor.primaryColor.withOpacity(0.5))),
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        labelText: AllString.password,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AllColor.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AllColor.primaryColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AllColor.primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide:
                                BorderSide(color: AllColor.primaryColor)),
                      ),
                    ),
                  ),
                  Center(
                    child: customButton(
                      context,
                      loading: _loading,
                      color: _usernameTextEditingController.text.length >= 10 &&
                              result &&
                              _passwordTextEditingController.text.length >= 1 &&
                              result &&
                              uservalue10digit
                          ? AllColor.primaryColor
                          : AllColor.greyColor,
                      function: () {
                        if (_usernameTextEditingController.text.length >= 10 &&
                            _passwordTextEditingController.text.length >= 7 &&
                            result &&
                            uservalue10digit) {
                          log("sucess");
                          userLogin();
                        } else {
                          log("fail");
                        }
                      },
                      text: AllString.login,
                    ),
                  ),
                ],
              ),
            )),
          ),
        ));
  }

  customTextField(
    String title,
    TextEditingController controller,
    IconData icon,
    int maxLength,
    TextInputAction textInputAction,
    TextInputType textInputType, {
    Function(String)? onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02, vertical: screenHeight * 0.008),
      child: TextFormField(
        maxLength: maxLength,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorTextuser.isEmpty ? null : errorTextuser,
          counterText: "",
          prefixIcon: Icon(icon,
              size: screenWidth * 0.05, color: AllColor.primaryColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide:
                  BorderSide(color: AllColor.primaryColor.withOpacity(0.2))),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          labelText: title,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AllColor.primaryColor)),
        ),
      ),
    );
  }

  userLogin() {
    setState(() {
      _loading = true;
    });
    Map data = {
      "name": _usernameTextEditingController.text,
      "job": _passwordTextEditingController.text
    };
    commonApiPostRequest(
      data,
      "https://reqres.in/api/users",
      context,
    ).then((responce) {
      if (responce == null) {
        print("Server Error");
      } else {
        Map<String, dynamic> jsonData = jsonDecode(responce.body);
        if (jsonData["id"] != null) {
          setState(() {
            _loading = false;
          });
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) => DashBoard()));
        }
      }
    });
  }
}
