import 'package:bloc_boiler_plate/core/network/api_result.dart';
import 'package:bloc_boiler_plate/data/repositories/auth_repository.dart';
import 'package:bloc_boiler_plate/presentation/register/bloc/register_event.dart';
import 'package:bloc_boiler_plate/presentation/register/bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({AuthRepository? repository}) : _repository = repository ?? AuthRepository(), super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onSubmitted);
    on<PasswordObscureToggled>(_onObscureToggled);
    on<ConfirmPasswordObscureToggled>(_onConfirmPasswordObscureToggled);
  }
  final AuthRepository _repository;

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await _repository.register(event.name, event.email, event.password);
    result.fold((data) => emit(RegisterSuccess()), (failure) => emit(RegisterError(failure, state.obscurePassword, state.confirmBbscurePassword)));
  }

  void _onObscureToggled(PasswordObscureToggled event, Emitter<RegisterState> emit) {
    final next = !state.obscurePassword;
    final newState = switch (state) {
      RegisterInitial() => RegisterInitial(next, state.confirmBbscurePassword),
      RegisterLoading() => RegisterLoading(next, state.confirmBbscurePassword),
      RegisterError(:final failure) => RegisterError(failure, next, state.confirmBbscurePassword),
      RegisterSuccess() => null,
    };
    if (newState != null) emit(newState);
  }

  void _onConfirmPasswordObscureToggled(ConfirmPasswordObscureToggled event, Emitter<RegisterState> emit) {
    final next = !state.confirmBbscurePassword;
    final newState = switch (state) {
      RegisterInitial() => RegisterInitial(state.obscurePassword, next),
      RegisterLoading() => RegisterLoading(state.obscurePassword, next),
      RegisterError(:final failure) => RegisterError(failure, state.obscurePassword, next),
      RegisterSuccess() => null,
    };
    if (newState != null) emit(newState);
  }
}
