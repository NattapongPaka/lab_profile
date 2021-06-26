import 'package:flutter/material.dart';

enum Status { SUCCESS, ERROR, LOADING , EMPTY}

class Resource<T> {
  final Status status;
  final T data;
  final String msg;

  Resource({
    @required this.status,
    @required this.data,
    this.msg,
  });
}
