class UpdateRatingModal {
  String className;
  String objectId;
  DateTime updatedAt;
  String rating;
  String ratingPoint;

  UpdateRatingModal({
    required this.className,
    required this.objectId,
    required this.updatedAt,
    required this.rating,
    required this.ratingPoint,
  });

  factory UpdateRatingModal.fromJson(Map<String, dynamic> json) =>
      UpdateRatingModal(
        className: json["className"],
        objectId: json["objectId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        rating: json["rating"],
        ratingPoint: json["ratingPoint"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "updatedAt": updatedAt.toIso8601String(),
        "rating": rating,
        "ratingPoint": ratingPoint,
      };
}
