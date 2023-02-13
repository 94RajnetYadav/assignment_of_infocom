import 'package:assigment/main.dart';
import 'package:assigment/screen/auth/login_screen.dart';
import 'package:assigment/utils/allColors/allColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation = Tween(begin: 0.0, end: 230.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();

    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AllColor.white,
      body: Center(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: AllColor.white,
          child: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                child: Center(
                  child: SizedBox(
                      height: animation.value,
                      width: animation.value,
                      child: Image.asset("assets/images/logo.png")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
