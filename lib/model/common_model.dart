class CommonModel {
  final String message;

  CommonModel({
    required this.message,
  });

  factory CommonModel.fromJson(dynamic json) {
    if (json.isEmpty) {
      return CommonModel(message: "");
    }

    return CommonModel(
      message: json['message'],
    );
  }

  @override
  String toString() {
    return '{"response": "$message"}';
  }
}
