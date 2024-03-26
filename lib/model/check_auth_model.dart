class CheckAuthModel {
  final int id;
  final String name;
  final String username;
  final String puskesmas;
  final String token;

  CheckAuthModel({
    required this.id,
    required this.name,
    required this.username,
    required this.puskesmas,
    required this.token,
  });

  // factory CheckAuthModel.fromJson(dynamic json) {
  //   dynamic response = json;
  //   if (response is List) {
  //     // Handle case 2
  //     if (response.isNotEmpty) {
  //       // If response is a list and not empty, take the first item
  //       return CheckAuthModel.fromJson(response[0]);
  //     } else {
  //       // Handle case 3
  //       return CheckAuthModel(
  //         id: 0,
  //         name: '',
  //         username: '',
  //         puskesmas: '',
  //         token: '',
  //       );
  //     }
  //   } else if (response is Map<String, dynamic>) {
  //     // Handle case 1
  //     return CheckAuthModel(
  //       id: response['id'] ?? 0,
  //       name: response['nama'] ?? '',
  //       username: response['username'] ?? '',
  //       puskesmas: response['puskesmas'] ?? '',
  //       token: response['_token'] ?? '',
  //     );
  //   } else {
  //     throw Exception("Unexpected response format");
  //   }
  // }

  factory CheckAuthModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return CheckAuthModel(
        id: json['id'] ?? 0,
        name: json['nama'] ?? '',
        username: json['username'] ?? '',
        puskesmas: json['puskesmas'] ?? '',
        token: json['_token'] ?? '',
      );
    } else {
      return CheckAuthModel(
        id: 0,
        name: '',
        username: '',
        puskesmas: '',
        token: '',
      );
    }
  }
}
