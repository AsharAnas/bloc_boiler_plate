import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  const LoginResponse({required this.token});

  final String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(token: json['token'] as String);

  @override
  List<Object?> get props => [token];
}
