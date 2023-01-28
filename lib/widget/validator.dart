

import 'package:flutter/material.dart';




String? nameValidator(value, BuildContext context) {
  RegExp regex = RegExp('^[a-zA-Z]+(?:s[a-zA-Z]+)?');
  if (value!.isEmpty) {
    return ("Please Paste Copied Link");
  }

  if (!regex.hasMatch(value.toString())) {
    return ("Please Paste Copied Link");
  }
  return null;
}

String? titleValidator(value) {
  RegExp regex = RegExp(r'^.{8,}$');
  if (value!.isEmpty) {
    return ("Please paste copied link");
  }
  
  return null;
}

