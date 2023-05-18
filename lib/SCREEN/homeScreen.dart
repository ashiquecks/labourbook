import 'package:employees_book/FUNCTION/apiCallback.dart';
import 'package:employees_book/MODAL/labourListModal.dart';
import 'package:employees_book/PROVIDER/labourListProvider.dart';
import 'package:employees_book/PROVIDER/mainProvider.dart';
import 'package:employees_book/SERVICE/updateRating.dart';
import 'package:employees_book/WIDGETS/appButton.dart';
import 'package:employees_book/WIDGETS/appCards.dart';
import 'package:employees_book/WIDGETS/appText.dart';
import 'package:employees_book/WIDGETS/designElements.dart';
import 'package:employees_book/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getLabourListResponse(context: context);
  }

  double ratingCount = 0;

  createNewRatings({
    required String ratingPoint,
    required String rating,
    required String objectId,
  }) {
    final provider = Provider.of<MainProvider>(context, listen: false);
    final providerList =
        Provider.of<LabourListProvider>(context, listen: false);
    double newRatingPont = double.parse(ratingPoint) + provider.ratingPoint;
    double newRating = double.parse(rating) + ratingCount;

    providerList.labourList.clear();

    updateLabourRatingRespose(
      objectId: objectId,
      labourRating: newRating,
      ratingPoint: newRatingPont,
    );
  }

  updateLabourRatingRespose({
    required String objectId,
    required double labourRating,
    required double ratingPoint,
  }) async {
    final provider = Provider.of<MainProvider>(context, listen: false);

    final response = await updateLaborRating(
      objectId: objectId,
      labourRating: labourRating.toString(),
      ratingPont: ratingPoint.toString(),
    );

    if (response.data!.objectId != null) {
      provider.setRating(0);

      getLabourListResponse(context: context);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: messageText(labelText: ' Successfully Updated'),
          duration: Duration(seconds: 3),
        ));
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: messageText(labelText: response.message.toString()),
          duration: Duration(seconds: 3),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    final provider = Provider.of<MainProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: minimalPadding,
            ),
            width: widgetSize.width,
            color: primaryColor,
            child: ListTile(
              title: headLineText(headlineText: "Add Labour"),
              subtitle: const Text(
                "create employees detailes with perfomance rating..",
              ),
              trailing: cardIconButton(buttonAction: () {
                Navigator.pushNamed(context, '/labourRegister');
              }),
            ),
          ),
        ),
        body: Consumer<LabourListProvider>(builder: (context, value, child) {
          return value.isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.labourList.length,
                  itemBuilder: (context, index) {
                    LabourListModal responsePost = value.getPostByIndex(index);
                    return Container(
                      height: widgetSize.height / 6,
                      margin: const EdgeInsets.all(minimalPadding),
                      padding: const EdgeInsets.all(minimalPadding),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  responsePost.file.url,
                                ),
                              ),
                              const SizedBox(width: defaultPadding),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  boltLabelText(
                                      labelText: responsePost.labourName),
                                  Text(responsePost.labourCategory),
                                  dotedDesignRow(),
                                  mainRichText(ratingCount: responsePost.rating)
                                ],
                              ),
                            ],
                          ),
                          ratingBox(
                            context: context,
                            ratingCount: responsePost.ratingPoint,
                            buttonAction: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  double displyRatingCount = 0;
                                  return Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: defaultPadding),
                                        Container(
                                          padding: EdgeInsets.all(25),
                                          margin: const EdgeInsets.all(10),
                                          child: RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                ratingCount = rating;
                                                displyRatingCount = rating;
                                              });
                                              provider.setRating(rating);
                                            },
                                          ),
                                        ),
                                        mainButton(
                                            // Increase and Update new Rating Counts and Old Rating Counds
                                            context: context,
                                            buttonAction: () {
                                              Navigator.of(context).pop(true);
                                              createNewRatings(
                                                  ratingPoint:
                                                      responsePost.ratingPoint,
                                                  rating: responsePost.rating,
                                                  objectId:
                                                      responsePost.objectId);
                                            },
                                            buttonText: "UPDATE")
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    );
                  });
        }),
      ),
    );
  }
}
