import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:get_it/get_it.dart';
import 'package:profile/src/app.dart';
import 'package:profile/src/data/db/db.dart';
import 'package:profile/src/di/injection.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  Future onCreate(BlocBase cubit) async {
    super.onCreate(cubit);
    print('onCreate : ${cubit.runtimeType}');
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    print('onChange : ${cubit.runtimeType}, change: $change');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    print('onError : ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(BlocBase cubit) {
    super.onClose(cubit);
    print('onClose : ${cubit.runtimeType}');
  }
}

void main() async {
  await init();
  Bloc.observer = SimpleBlocDelegate();
  await Stetho.initialize();
  await GetIt.I<Db>().database;

  runApp(
    RouteObserverProvider(
      child: MyApp(),
    ),
  );
}
