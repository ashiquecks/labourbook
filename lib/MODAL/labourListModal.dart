class LabourListModal {
  String className;
  String objectId;
  DateTime createdAt;
  DateTime updatedAt;
  FileClass file;
  String labourName;
  String labourCategory;
  String rating;
  String ratingPoint;

  LabourListModal({
    required this.className,
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    required this.file,
    required this.labourName,
    required this.labourCategory,
    required this.rating,
    required this.ratingPoint,
  });

  factory LabourListModal.fromJson(Map<String, dynamic> json) =>
      LabourListModal(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        file: FileClass.fromJson(json["file"]),
        labourName: json["labourName"],
        labourCategory: json["labourCategory"],
        rating: json["rating"],
        ratingPoint: json["ratingPoint"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "file": file.toJson(),
        "labourName": labourName,
        "labourCategory": labourCategory,
        "rating": rating,
        "ratingPoint": ratingPoint,
      };
}

class FileClass {
  String type;
  String name;
  String url;

  FileClass({
    required this.type,
    required this.name,
    required this.url,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        type: json["__type"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "name": name,
        "url": url,
      };
}
