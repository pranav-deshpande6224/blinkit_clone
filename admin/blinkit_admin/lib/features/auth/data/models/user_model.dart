import 'package:blinkit_admin/core/common/entities/profile_user.dart';

class UserModel extends ProfileUser {
  UserModel({
    required super.token,
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  UserModel copyWith({
    String? token,
    String? email,
    String? name,
  }) {
    return UserModel(
      token: token ?? this.token,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

}
