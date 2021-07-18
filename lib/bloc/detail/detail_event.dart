part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class DetailInitialEvent extends DetailEvent {}

class LoadedDetailEvent extends DetailEvent {
  final String id;

  LoadedDetailEvent({required this.id});
}

class PostDetailReviewEvent extends DetailEvent {
  final String id;
  final String name;
  final String review;

  PostDetailReviewEvent(
      {required this.id, required this.name, required this.review});
}
