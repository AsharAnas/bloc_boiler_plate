import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/models/post.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded(this.posts);

  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

final class HomeError extends HomeState {
  const HomeError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
