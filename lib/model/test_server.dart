class TestServerModel {
  final String message;

  TestServerModel({
    required this.message,
  });

  factory TestServerModel.fromJson(dynamic json) {
    return TestServerModel(
      message: json ?? '',
    );
  }
}
