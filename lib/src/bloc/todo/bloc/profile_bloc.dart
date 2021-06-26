import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:profile/src/data/service/todo_service.dart';
import 'package:profile/src/models/resource_model.dart';
import 'package:profile/src/models/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TodoService todoService;
  final Logger logger;

  ProfileBloc({
    this.todoService,
    this.logger,
  }) : super(TodoInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is AddTodoEvent) {
      final todoItem = event.todoItem;
      final Resource result = await todoService.addProfile(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield TodoAddCompleteState(resource: result);
      } else {
        yield TodoAddFaileState(resource: result);
      }
    }

    if (event is GetTodoAllEvent) {
      final Resource result = await todoService.getProfileAll();
      if (result.status == Status.SUCCESS) {
        //logger.d(result.data);
        yield GetTodoAllCompleteState(resource: result);
      } else {
        yield GetTodoAllEmptyState();
      }
    }

    if (event is UpdateTodoEvent) {
      final todoItem = event.todoItem;
      final Resource result =
          await todoService.updateProfile(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
      } else {
        yield UpdateTodoFaileState();
      }
    }

    if (event is TodoDoneEvent) {
      final todoItem = event.todoItem;
      final Resource result =
          await todoService.updateProfile(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
      } else {
        yield UpdateTodoFaileState();
      }
    }

    if (event is GetTodoDoneAllEvent) {
      final Resource result = await todoService.getTodoDoneAll();
      if (result.status == Status.SUCCESS) {
        //logger.d(result.data);
        yield GetTodoDoneAllCompleteState(resource: result);
      } else {
        yield GetTodoDoneAllEmptyState();
      }
    }

    if (event is TodoDeleteEvent) {
      final todoItem = event.todoItem;
      final Resource result =
          await todoService.deleteProfile(todoId: todoItem.id);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
        add(GetTodoAllEvent());
      }
    }

    if (event is SearchEvent) {
      final searchText = event.searchText;
      final Resource result = await todoService.getProfileBySearchText(
        text: searchText,
      );
      if (result.status == Status.SUCCESS) {
        //logger.d(result.data);
        yield GetTodoAllCompleteState(resource: result);
      } else {
        yield GetTodoAllEmptyState();
      }
    }
  }
}
