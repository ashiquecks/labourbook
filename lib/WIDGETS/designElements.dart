import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';

Widget dotedDesignRow() {
  return Row(
    children: [
      dotedContainer(containerColor: primaryColor),
      dotedContainer(containerColor: primaryColor),
      dotedContainer(containerColor: primaryColor),
      dotedContainer(containerColor: primaryColor),
      dotedContainer(containerColor: Colors.grey),
      dotedContainer(containerColor: Colors.grey),
    ],
  );
}

Widget dotedContainer({
  required Color containerColor,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    width: 20,
    height: 5,
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
