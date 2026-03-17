import 'package:flutter/material.dart';

class SpiceControllers {
  final name = TextEditingController();
  final weight = TextEditingController();

  void dispose() {
    name.dispose();
    weight.dispose();
  }
}
