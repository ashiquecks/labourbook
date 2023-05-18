class LabourCreateModal {
  String className;
  String objectId;
  DateTime createdAt;
  String labourName;
  String labourCategory;
  String rating;

  LabourCreateModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.labourName,
    required this.labourCategory,
    required this.rating,
  });

  factory LabourCreateModal.fromJson(Map<String, dynamic> json) =>
      LabourCreateModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        labourName: json["labourName"],
        labourCategory: json["labourCategory"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "labourName": labourName,
        "labourCategory": labourCategory,
        "rating": rating,
      };
}
