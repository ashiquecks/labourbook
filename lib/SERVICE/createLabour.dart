import 'dart:convert';
import 'dart:io';
import 'package:employees_book/MODAL/labourCreate.dart';
import 'package:employees_book/RESPONSE/networkRespose.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<LabourCreateModal>> createNewLabour(
    {required final parseFile,
    required String lauborName,
    required String labourCategory,
    required String labourRating,
    required String ratingPont}) async {
  try {
    final gallery = ParseObject('Gallery')
      ..set('file', parseFile)
      ..set('labourName', lauborName)
      ..set('labourCategory', labourCategory)
      ..set('rating', labourRating)
      ..set('ratingPoint', ratingPont);
    await gallery.save();

    print(gallery);

    if (gallery.objectId != null) {
      final jsonString = jsonEncode(gallery);
      LabourCreateModal responseData =
          LabourCreateModal.fromJson(jsonDecode(jsonString));

      return NetworkResponse(
        true,
        responseData,
      );
    } else {
      return NetworkResponse(
        false,
        null,
        message:
            'Invalid response recived from server! please try again in a minutes or two',
      );
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message:
          "Unable to reach the internet! Please try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message:
          "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'somthing went wrong please try again in a minute or two');
  }
  throw Exception('Unexpected error occured!');
}
