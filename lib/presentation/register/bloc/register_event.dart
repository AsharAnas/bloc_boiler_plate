import 'package:equatable/equatable.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted({required this.email, required this.password, required this.name, required this.confirmPassword, required this.phone});
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  @override
  List<Object?> get props => [email, password, confirmPassword, phone];
}

final class PasswordObscureToggled extends RegisterEvent {
  const PasswordObscureToggled();
}

final class ConfirmPasswordObscureToggled extends RegisterEvent {
  const ConfirmPasswordObscureToggled();
}
