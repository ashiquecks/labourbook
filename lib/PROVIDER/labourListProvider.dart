import 'package:employees_book/MODAL/labourCreate.dart';
import 'package:employees_book/MODAL/labourListModal.dart';
import 'package:flutter/cupertino.dart';

class LabourListProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<LabourListModal> _labourList = [];
  bool get isProcessing => _isProcessing;

  setProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<LabourListModal> get labourList => _labourList;

  setLabourList(List<LabourListModal> list) {
    _labourList.addAll(list);
    notifyListeners();
  }

  mergeLabourList(List<LabourListModal> list) {
    _labourList = list;
    notifyListeners();
  }

  LabourListModal getPostByIndex(int index) => _labourList[index];
}
