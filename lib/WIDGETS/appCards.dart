import 'package:employees_book/PROVIDER/mainProvider.dart';
import 'package:employees_book/WIDGETS/appText.dart';
import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

Widget ratingBox({
  required BuildContext context,
  required String ratingCount,
  required void Function() buttonAction,
}) {
  return Positioned(
    right: 0,
    child: Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 30,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: TextButton.icon(
        onPressed: buttonAction,
        icon: const Icon(
          Icons.star_border_outlined,
          size: 16,
          color: white,
        ),
        label: Text(
          ratingCount,
          style: TextStyle(color: white),
        ),
      ),
    ),
  );
}

Widget imageUploadCard({
  required BuildContext context,
}) {
  return Positioned(
    bottom: 0,
    right: 0,
    child: Container(
      width: 120,
      height: 25,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
        ),
      ),
      child: const Text("Upload Image"),
    ),
  );
}

Widget imagePickerContainer({
  required BuildContext context,
  required void Function() cardAction,
}) {
  return InkWell(
    onTap: cardAction,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/pick_image.jpg"),
            fit: BoxFit.cover),
      ),
    ),
  );
}
