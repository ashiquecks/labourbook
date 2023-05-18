import 'dart:convert';
import 'dart:io';
import 'package:employees_book/MODAL/labourListModal.dart';
import 'package:employees_book/RESPONSE/networkRespose.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<List<LabourListModal>>> getLabourList() async {
  try {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('Gallery'))
          ..orderByDescending('ratingPoint');
    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.statusCode == 200) {
      final jsonString = jsonEncode(apiResponse.results);
      final convertJson = await jsonDecode(jsonString);
      List<LabourListModal> labourList = [];
      convertJson.forEach((e) {
        LabourListModal bookListResponse = LabourListModal.fromJson(e);
        labourList.add(bookListResponse);
      });
      return NetworkResponse(true, labourList);
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
