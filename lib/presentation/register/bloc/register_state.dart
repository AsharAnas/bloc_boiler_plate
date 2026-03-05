import 'package:bloc_boiler_plate/core/errors/failures.dart';
import 'package:equatable/equatable.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
  bool get obscurePassword => true;
  bool get confirmBbscurePassword => true;
  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial([this.obscurePassword = true, this.confirmBbscurePassword = true]);
  @override
  final bool obscurePassword;
  @override
  final bool confirmBbscurePassword;
  @override
  List<Object?> get props => [obscurePassword, confirmBbscurePassword];
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading([this.obscurePassword = true, this.confirmBbscurePassword = true]);
  @override
  final bool obscurePassword;
  @override
  final bool confirmBbscurePassword;
  @override
  List<Object?> get props => [obscurePassword, confirmBbscurePassword];
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

final class RegisterError extends RegisterState {
  const RegisterError(this.failure, [this.obscurePassword = true, this.confirmBbscurePassword = true]);
  final Failure failure;
  @override
  final bool obscurePassword;
  @override
  final bool confirmBbscurePassword;
  @override
  List<Object?> get props => [failure, obscurePassword, confirmBbscurePassword];
}
