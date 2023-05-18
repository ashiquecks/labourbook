import 'package:employees_book/PROVIDER/labourListProvider.dart';
import 'package:employees_book/SERVICE/getLabourList.dart';
import 'package:employees_book/WIDGETS/appText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

getLabourListResponse({
  required BuildContext context,
}) async {
  var provider = Provider.of<LabourListProvider>(context, listen: false);
  var response = await getLabourList();
  if (response.isSuccessful!) {
    if (provider.labourList.length < response.data!.length) {
      provider.labourList.clear();
      provider.setLabourList(response.data!);
    } else {}
  } else {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: messageText(labelText: response.message.toString()),
        duration: Duration(seconds: 3),
      ));
  }
  provider.setProcessing(false);
}
