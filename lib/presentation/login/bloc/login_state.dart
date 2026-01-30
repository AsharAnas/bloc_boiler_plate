import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/models/login_response.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  bool get obscurePassword => true;
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial([this.obscurePassword = true]);
  @override
  final bool obscurePassword;
  @override
  List<Object?> get props => [obscurePassword];
}

final class LoginLoading extends LoginState {
  const LoginLoading([this.obscurePassword = true]);
  @override
  final bool obscurePassword;
  @override
  List<Object?> get props => [obscurePassword];
}

final class LoginSuccess extends LoginState {
  const LoginSuccess(this.response);
  final LoginResponse response;
  @override
  List<Object?> get props => [response];
}

final class LoginError extends LoginState {
  const LoginError(this.failure, [this.obscurePassword = true]);
  final Failure failure;
  @override
  final bool obscurePassword;
  @override
  List<Object?> get props => [failure, obscurePassword];
}
