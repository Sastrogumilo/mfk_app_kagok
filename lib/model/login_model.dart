class UserLoginModel {
  final int id;
  final String nama;
  final String username;
  final String puskesmas;
  final String token;
  final int isAdmin;
  final int status;
  final List<String> menu;

  UserLoginModel({
    required this.id,
    required this.nama,
    required this.username,
    required this.puskesmas,
    required this.token,
    required this.isAdmin,
    required this.status,
    required this.menu,
  });

  factory UserLoginModel.fromJson(dynamic json) {
    if (json.isEmpty) {
      return UserLoginModel(
          id: 0,
          nama: '',
          username: '',
          puskesmas: '',
          token: '',
          isAdmin: 0,
          status: 0,
          menu: []);
    }

    return UserLoginModel(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      puskesmas: json['puskesmas'],
      token: json['_token'],
      isAdmin: json['is_admin'],
      status: json['status'],
      menu: (json['menu'] as String).split(',').toList(),
    );
  }

  @override
  String toString() {
    return '{"id": $id, "nama": "$nama", "username": "$username", "puskesmas": "$puskesmas", "_token": "$token", "is_admin": $isAdmin, "status": $status, "menu": "$menu"}';
  }
}
