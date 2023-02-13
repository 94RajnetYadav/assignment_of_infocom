import 'package:flutter/material.dart';

import '../utils/allColors/allColors.dart';

commonDashBoardAppBar(
  title, {
  Function()? onTap,
  bool centerTitle = false,
  Widget? leading,
}) {
  return AppBar(
    title: title,
    centerTitle: true,
    elevation: 0,
    leading: leading,
    backgroundColor: AllColor.blue,
  );
}
