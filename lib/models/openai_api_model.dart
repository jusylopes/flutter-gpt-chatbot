class OpenaiModel {
  final String id;
  final int created;
  final String root;

  OpenaiModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory OpenaiModel.fromJson(Map<String, dynamic> json) => OpenaiModel(
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
