import 'package:bloc_boiler_plate/core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/sample_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({SampleRepository? repository}) : _repository = repository ?? SampleRepository(), super(const HomeInitial()) {
    on<HomeLoadRequested>(_onLoadRequested);
  }

  final SampleRepository _repository;

  Future<void> _onLoadRequested(HomeLoadRequested event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    final result = await _repository.getPosts();
    result.fold((data) => emit(HomeLoaded(data)), (failure) => emit(HomeError(failure)));
  }
}
