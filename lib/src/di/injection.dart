import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:profile/src/bloc/todo/bloc/profile_bloc.dart';
import 'package:profile/src/data/db/db.dart';
import 'package:profile/src/data/service/todo_service.dart';
import 'package:profile/src/utils/index.dart';

var sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  await _initService();
  await _initBloc();
}

_initCore() async {
  // sl.registerSingleton();
  // var _streamingSharedPreferences = await StreamingSharedPreferences.instance;
  // var _packageInfo = await PackageInfo.fromPlatform();
  // // PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  // sl.registerLazySingleton(() => _packageInfo);
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton(() => Logger(
        filter: MyFilter(),
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
        output: null,
      ));

  // sl.registerSingleton(_streamingSharedPreferences);

  // sl.registerSingleton(SharedPreferenceHelper(
  //   sl(),
  //   sl(),
  // ));

  // sl.registerSingleton(HttpClient(
  //   preferenceHelper: sl(),
  //   flavorConfig: sl(),
  // ));
}

_initService() async {
  sl.registerFactory(() => Db(
        logger: sl(),
      ));

  sl.registerFactory(() => TodoService(
        db: sl(),
        logger: sl(),
      ));

  // sl.registerFactory(() => AuthService(
  //       sharedPreferences: sl(),
  //       httpClient: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => UserService(
  //       httpClient: sl(),
  //       logger: sl(),
  //       sharedPreferences: sl(),
  //     ));

  // sl.registerFactory(() => ExerciseService(
  //       httpClient: sl(),
  //       logger: sl(),
  //       sharedPreferences: sl(),
  //       db: sl(),
  //     ));

  // sl.registerFactory(() => SurveyService(
  //       httpClient: sl(),
  //       logger: sl(),
  //       sharedPreferences: sl(),
  //       db: sl(),
  //       firestore: sl(),
  //     ));
}

_initBloc() async {
  sl.registerFactory(() => ProfileBloc(
        todoService: sl(),
        logger: sl(),
      ));

  // sl.registerFactory(() => AuthenBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => ExerciseBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       exerciseService: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => ArticleBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       exerciseService: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => ExercisevdoBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       exerciseService: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => ReportBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       exerciseService: sl(),
  //       logger: sl(),
  //     ));

  // sl.registerFactory(() => QuestionBloc(
  //       authService: sl(),
  //       userService: sl(),
  //       exerciseService: sl(),
  //       surveyService: sl(),
  //       logger: sl(),
  //     ));
}
