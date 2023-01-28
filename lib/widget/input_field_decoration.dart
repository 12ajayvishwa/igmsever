import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hintText,{IconButton? iconButton, Widget? prefixIcon, String? labelText,}){
  return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
      hintText: hintText,
      labelText: labelText,
      counterText: "",
      labelStyle: const TextStyle(
          fontFamily: "oswald",
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black87),
      hintStyle: const TextStyle(
          fontFamily: "oswald",
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(168, 167, 167, 1)),
      
          prefixIcon: prefixIcon,
          suffixIcon: iconButton,
      filled: false,
      fillColor: const Color(0xFFF5F7FB),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueGrey,width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueGrey,width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueGrey,width: 2)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueGrey,width: 2)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueGrey,width: 2)));
}