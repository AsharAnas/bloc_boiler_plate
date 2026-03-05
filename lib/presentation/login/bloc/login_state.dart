import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/models/login_response.dart';
import '../../../../data/models/user.dart';

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
  const LoginSuccess(this.response, [this.user]);
  final LoginResponse response;
  /// Current user from getMe API (called after login with saved token).
  final User? user;
  @override
  List<Object?> get props => [response, user];
}

final class LoginError extends LoginState {
  const LoginError(this.failure, [this.obscurePassword = true]);
  final Failure failure;
  @override
  final bool obscurePassword;
  @override
  List<Object?> get props => [failure, obscurePassword];
}
