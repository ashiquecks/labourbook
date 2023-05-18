import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';

Widget headLineText({
  required String headlineText,
}) {
  return Text(
    headlineText,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget mainRichText({
  required String ratingCount,
}) {
  return RichText(
    text: TextSpan(children: [
      TextSpan(
        text: "Rating Count $ratingCount",
        style: const TextStyle(color: Colors.grey),
      ),
    ]),
  );
}

Widget messageText({
  required String labelText,
}) {
  return Text(
    labelText,
    style: const TextStyle(
      color: Colors.white,
    ),
  );
}
