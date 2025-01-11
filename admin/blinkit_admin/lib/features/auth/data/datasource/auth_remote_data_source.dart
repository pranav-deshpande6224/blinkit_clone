import 'dart:convert';

import 'package:blinkit_admin/core/error/exception.dart';
import 'package:blinkit_admin/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String baseUrl;
  final http.Client client;
  AuthRemoteDataSourceImpl({
    required this.baseUrl,
    required this.client,
  });
  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      final res = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return UserModel.fromJson(res);
      } else if (response.statusCode == 401) {
        print(res['detail']);
        throw ServerException(message: res['detail']);
      } else {
        throw ServerException(message: 'Unknown error occurred');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email, required String password, required String name}) {
    throw UnimplementedError();
  }
}
