import 'package:assigment/main.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:flutter/material.dart';

customButton(BuildContext context,
    {@required Function()? function,
    bool loading = false,
    Color color = Colors.white,
    Color textColor = Colors.white,
    String? text,
    double? width}) {
  return Container(
    // color: AllColor.red,
    // height: screenWidth * 0.12,
    margin: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.5,
          height: screenWidth * 0.12,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10000)),
            color: color,
            onPressed: function,
            child: loading
                ? CircularProgressIndicator()
                : Text(text!.toUpperCase(),
                    style: TextStyle(
                        fontSize: screenWidth >= 600
                            ? screenWidth * 0.035
                            : screenWidth * 0.035,
                        color: textColor)

                    //  normalTextStyle(color: textColor),
                    ),
          ),
        ),
      ],
    ),
  );
}
