part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailResponse detailResponse;
  final bool statusFavorite;

  DetailLoaded({required this.detailResponse, required this.statusFavorite});
}

class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});
}
