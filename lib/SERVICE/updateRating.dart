import 'dart:convert';
import 'dart:io';
import 'package:employees_book/MODAL/labourCreate.dart';
import 'package:employees_book/MODAL/updateRatingModal.dart';
import 'package:employees_book/RESPONSE/networkRespose.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<UpdateRatingModal>> updateLaborRating({
  required String objectId,
  required String labourRating,
  required String ratingPont,
}) async {
  try {
    var gallery = ParseObject('Gallery')
      ..objectId = objectId
      ..set('rating', labourRating)
      ..set('ratingPoint', ratingPont);
    await gallery.save();

    print(gallery);

    if (gallery.objectId != null) {
      final jsonString = jsonEncode(gallery);
      UpdateRatingModal responseData =
          UpdateRatingModal.fromJson(jsonDecode(jsonString));

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
