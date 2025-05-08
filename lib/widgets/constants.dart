import 'package:flutter/material.dart';

class Constants {
  final primaryColor = Color.fromARGB(255, 134, 107, 252);
  final secondaryColor = Color(0xffa1c6fd);
  final tertiaryColor = Color(0xff205cf1);
  final blackColor = Color(0xff000000);
  final greyColor = Color(0xffd9dadb);

  final Shader shader = LinearGradient(
    colors: [Color(0XffABcff2), Color.fromARGB(255, 75, 111, 147)],
  ).createShader(Rect.fromLTRB(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue = LinearGradient(
    colors: [Color(0XffABcff2), Color.fromARGB(255, 101, 156, 211)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1.0],
  );

  final linearGradientPurple = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xff51087e), Color(0xff7801c3)],
    stops: [0.0, 1.0],
  );
}
