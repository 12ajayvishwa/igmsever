import 'package:flutter/material.dart';

import 'input_field_decoration.dart';


class CustomTextFormFields extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  final String hintText;
  final int? maxLength;

  final String? labelText;
  final TextInputType? textInputType;
  final IconButton? iconButton;
  final bool? obsecureText;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  const CustomTextFormFields({
    Key? key,
    required this.size,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.textInputType,
    this.labelText,
    this.maxLength,
    this.prefixIcon,
    this.iconButton,
    this.obsecureText,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: size.height * 0.06,
            width: size.width ,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(8.0))),
        TextFormField(
          maxLength: maxLength,
          style: const TextStyle(fontFamily: "oswald", color: Colors.black),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
          autofocus: false,
          controller: controller,
          keyboardType: textInputType,
          onSaved: (value) {
            controller.text = value!;
          },
          textInputAction: textInputAction,
          validator: validator,
          decoration: inputDecoration(
            hintText,
            labelText: labelText,
            iconButton: iconButton,
            prefixIcon: prefixIcon,
          ),
          obscureText: obsecureText ?? false,
        ),
      ],
    );
  }
}

