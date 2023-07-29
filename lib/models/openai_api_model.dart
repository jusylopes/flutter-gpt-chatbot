class OpenApiModel {
  final String id;
  final int created;
  final String root;

  OpenApiModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory OpenApiModel.fromJson(Map<String, dynamic> json) => OpenApiModel(
        id: json["id"],
        created: json["created"],
        root: json["root"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "root": root,
      };
}
