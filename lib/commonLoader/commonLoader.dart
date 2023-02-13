import 'package:assigment/main.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

commonLoader() {
  return Center(
      child: Container(
    padding: EdgeInsets.all(screenWidth * 0.03),
    width: screenWidth * 0.4,
    height: screenWidth * 0.4,
    child: SpinKitSpinningLines(
      size: screenWidth * 0.1,
      color: AllColor.white,
    ),
  ));
}
