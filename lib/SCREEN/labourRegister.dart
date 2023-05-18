import 'dart:convert';
import 'dart:io';

import 'package:employees_book/FUNCTION/apiCallback.dart';
import 'package:employees_book/PROVIDER/mainProvider.dart';
import 'package:employees_book/SERVICE/createLabour.dart';
import 'package:employees_book/WIDGETS/appButton.dart';
import 'package:employees_book/WIDGETS/appCards.dart';
import 'package:employees_book/WIDGETS/appText.dart';
import 'package:employees_book/WIDGETS/appTextField.dart';
import 'package:employees_book/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class LabourRegister extends StatefulWidget {
  const LabourRegister({super.key});

  @override
  State<LabourRegister> createState() => _LabourRegisterState();
}

class _LabourRegisterState extends State<LabourRegister> {
  // get image from phone gallery..
  Future<void> getImage() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedFile = image;
      });
    }
  }

  TextEditingController labourNameControll = TextEditingController();
  TextEditingController labourCategoryControll = TextEditingController();

  double ratingCount = 0;

  PickedFile? pickedFile;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    final provider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Add Employees Detailes",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  pickedFile != null
                      ? kIsWeb
                          ? Image.network(pickedFile!.path)
                          : Image.file(File(pickedFile!.path))
                      : imagePickerContainer(
                          context: context,
                          cardAction: () {
                            getImage();
                          }),
                  imageUploadCard(
                    context: context,
                  )
                ],
              ),
              const SizedBox(height: defaultPadding),
              secondTextFiled(
                controllerText: labourNameControll,
                hintText: "Labour Name",
              ),
              secondTextFiled(
                controllerText: labourCategoryControll,
                hintText: "Labour Category",
              ),
              Card(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingCount = rating;
                        });
                        provider.setRating(rating);
                      },
                    ),
                    Container(
                      height: 80,
                      width: 100,
                      color: primaryColor,
                      alignment: Alignment.center,
                      child: headLineText(headlineText: ratingCount.toString()),
                    )
                  ],
                ),
              ),
              mainButton(
                  context: context,
                  buttonAction: () async {
                    print(provider.ratingPoint);
                    setState(() {
                      loading = true;
                    });
                    ParseFileBase? parseFile;

                    if (kIsWeb) {
                      parseFile = ParseWebFile(await pickedFile!.readAsBytes(),
                          name: 'image.jpg');
                    } else {
                      parseFile = ParseFile(File(pickedFile!.path));
                    }
                    await parseFile.save();

                    final response = await createNewLabour(
                      parseFile: parseFile,
                      lauborName: labourNameControll.text,
                      labourCategory: labourCategoryControll.text,
                      labourRating: ratingCount.toString(),
                      ratingPont: provider.ratingPoint.toString(),
                    );

                    if (response.data != null) {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content:
                              messageText(labelText: 'Successfully Created'),
                          duration: Duration(seconds: 3),
                        ));
                      setState(() {
                        loading = false;
                      });

                      provider.setRating(0);

                      getLabourListResponse(context: context);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: messageText(
                              labelText: response.message.toString()),
                          duration: Duration(seconds: 3),
                        ));

                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  buttonText: loading == true ? "Loading..." : "SUBMIT")
            ],
          ),
        ),
      ),
    );
  }
}
