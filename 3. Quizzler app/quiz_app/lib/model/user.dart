import 'dart:math';

import 'package:flutter/material.dart';

class User {
  String name;
  int points = Random().nextInt(1001);
  String avatar = "";
  final profileColor =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  User(this.name, this.avatar);
}
