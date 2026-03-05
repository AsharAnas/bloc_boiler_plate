import 'package:bloc_boiler_plate/core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({AuthRepository? repository}) : _repository = repository ?? AuthRepository(), super(const LoginInitial()) {
    on<LoginSubmitted>(_onSubmitted);
    on<PasswordObscureToggled>(_onObscureToggled);
  }

  final AuthRepository _repository;

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading(state.obscurePassword));
    final result = await _repository.login(event.email, event.password);
    await result.fold((data) async {
      // Token is saved in AuthRepository; getMe uses it via headers.
      final meResult = await _repository.getMe();
      meResult.fold((user) => emit(LoginSuccess(data, user)), (_) => emit(LoginSuccess(data)));
    }, (failure) async => emit(LoginError(failure, state.obscurePassword)));
  }

  void _onObscureToggled(PasswordObscureToggled event, Emitter<LoginState> emit) {
    final next = !state.obscurePassword;
    final newState = switch (state) {
      LoginInitial() => LoginInitial(next),
      LoginLoading() => LoginLoading(next),
      LoginError(:final failure) => LoginError(failure, next),
      LoginSuccess() => null,
    };
    if (newState != null) emit(newState);
  }
}
