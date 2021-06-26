import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:profile/src/data/db/db.dart';
import 'package:profile/src/models/resource_model.dart';
import 'package:profile/src/models/profile.dart';

class TodoService {
  final Db db;
  final Logger logger;

  TodoService({
    this.db,
    this.logger,
  });

  Future<Resource<int>> addProfile({Profile todoItem}) async {
    int result = await db.insertProfile(todo: todoItem);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Add todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Add todo faile",
      );
    }
  }

  Future<Resource<int>> updateProfile({Profile todoItem}) async {
    int result = await db.updateUpdateProfile(todo: todoItem);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Update todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Update todo faile",
      );
    }
  }

  getProfileAll() async {
    List<Profile> result = await db.getProfileAll();
    if (result.isNotEmpty) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "All todo",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Empty...",
      );
    }
  }

  getTodoDoneAll() async {
    List<Profile> result = await db.getTodoDoneAll();
    if (result.isNotEmpty) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "All todo",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Empty...",
      );
    }
  }

  deleteProfile({@required int todoId}) async {
    final int result = await db.deleteProfile(todoId);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Delete todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Delete todo faile",
      );
    }
  }

  getProfileBySearchText({String text}) async {
    List<Profile> result = await db.getProfileByQuery(text: text);
    if (result.isNotEmpty) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "All todo",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Empty...",
      );
    }
  }
}
