part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class AddTodoEvent extends ProfileEvent {
  final Profile todoItem;

  AddTodoEvent({this.todoItem});
}

class GetTodoAllEvent extends ProfileEvent {}

class GetTodoDoneAllEvent extends ProfileEvent {}

class UpdateTodoEvent extends ProfileEvent {
  final Profile todoItem;

  UpdateTodoEvent({this.todoItem});
}

class TodoDoneEvent extends ProfileEvent {
  final Profile todoItem;

  TodoDoneEvent({this.todoItem});
}

class TodoDeleteEvent extends ProfileEvent {
  final Profile todoItem;

  TodoDeleteEvent({this.todoItem});
}

class SearchEvent extends ProfileEvent {
  final String searchText;

  SearchEvent({this.searchText});
}
