import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';

Widget mainTextFiled({
  required TextEditingController controllerText,
  required IconData perfixIcon,
  required String hintText,
  required bool obsecure,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: minimalPadding),
    child: Card(
      elevation: 6,
      child: TextFormField(
        obscureText: obsecure,
        controller: controllerText,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(perfixIcon),
        ),
      ),
    ),
  );
}

Widget secondTextFiled({
  required TextEditingController controllerText,
  required String hintText,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: minimalPadding),
    child: Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controllerText,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}
