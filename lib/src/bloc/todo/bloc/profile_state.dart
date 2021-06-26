part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class TodoInitial extends ProfileState {}

class TodoAddCompleteState extends ProfileState {
  final Resource resource;

  TodoAddCompleteState({this.resource});
}

class TodoAddFaileState extends ProfileState {
  final Resource resource;
  TodoAddFaileState({this.resource});
}

class GetTodoAllCompleteState extends ProfileState {
  final Resource resource;
  GetTodoAllCompleteState({this.resource});
}

class GetTodoAllEmptyState extends ProfileState {}

// class GetTodoDoneAllCompleteState extends TodoState {
//   final Resource resource;

//   GetTodoDoneAllCompleteState({this.resource});
// }

class UpdateTodoCompleteState extends ProfileState {}

class UpdateTodoFaileState extends ProfileState {}

class GetTodoDoneAllCompleteState extends ProfileState {
  final Resource resource;

  GetTodoDoneAllCompleteState({this.resource});
}

class GetTodoDoneAllEmptyState extends ProfileState {}
