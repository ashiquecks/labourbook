import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  // rating bar section
  double ratingPoint = 0;

  setRating(double paasedRating) {
    if (paasedRating == 0.5) {
      ratingPoint = 0.025;
    } else if (paasedRating == 1) {
      ratingPoint = 0.05;
    } else if (paasedRating == 1.5) {
      ratingPoint = 0.075;
    } else if (paasedRating == 2) {
      ratingPoint = 0.1;
    } else if (paasedRating == 2.5) {
      ratingPoint = 0.125;
    } else if (paasedRating == 3) {
      ratingPoint = 0.15;
    } else if (paasedRating == 3.5) {
      ratingPoint = 0.175;
    } else if (paasedRating == 4) {
      ratingPoint = 0.2;
    } else if (paasedRating == 4.5) {
      ratingPoint = 0.225;
    } else if (paasedRating == 5) {
      ratingPoint = 0.25;
    } else {
      ratingPoint = 0;
    }
    notifyListeners();
  }
}
