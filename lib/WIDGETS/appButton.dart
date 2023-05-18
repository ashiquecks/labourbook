import 'dart:ffi';

import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';

Widget mainButton({
  required BuildContext context,
  required void Function() buttonAction,
  required String buttonText,
}) {
  return Card(
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: buttonAction,
        child: Text(buttonText),
      ),
    ),
  );
}

Widget boltLabelText({required String labelText}) {
  return Text(
    labelText,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget cardIconButton({
  required void Function() buttonAction,
}) {
  return Card(
    child: IconButton(
      icon: const Icon(
        Icons.add,
        color: primaryColor,
      ),
      onPressed: buttonAction,
    ),
  );
}
