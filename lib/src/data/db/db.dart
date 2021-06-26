import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:profile/src/models/profile.dart';

import 'db_entity.dart';

class Db {
  final Logger logger;

  Db({this.logger});

  final _initScript = [
    ProfileEntity.createTable,
    // PlanLevelEntity.createTable,
    // LevelEntity.createTable,
    // WorkoutEntity.createTable,
    // HealthDataPointEntity.createTable,
  ];
  // '''
  // CREATE TABLE IF NOT EXISTS image_path (
  //   id text primary key,
  //   path text
  // );
  // '''
  // final _migrationScripts = [
  //   HealthDataPointEntity.createTable,
  // ];
  // final _migration_1_5 = [
  //   HealthDataPointEntity.createTable,
  // ];

  Completer<BriteDatabase> _dbOpenCompleter;

  // DatabaseFactory dbFactory = databaseFactoryIo;

  Future<BriteDatabase> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _init();
    }
    return _dbOpenCompleter.future;
  }

  _init() async {
    // Get a platform-specific directory where persistent app data can be stored
    String dbName = "profile.db";
    int dbVersion = 1;

    var databasesPath = await getDatabasesPath();

    // Directory appDocumentDir = await getApplicationDocumentsDirectory();
    // //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // if (Platform.isAndroid) {
    //   Directory databaseDirectory = Directory("data/data/app.ucconnect.eatfin" + '/databases');
    //   if (await databaseDirectory.exists() && await File(databaseDirectory.path + '/' + dbName).exists()) {
    //     appDocumentDir = databaseDirectory;
    //   }
    // }
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(databasesPath, dbName);

    final database = await openDatabase(
      dbPath,
      onCreate: (db, version) => _onCreateDB(db, version),
      onUpgrade: (db, oldVersion, newVersion) => _onUpgradeDB(
        db,
        oldVersion,
        newVersion,
      ),
      version: dbVersion,
      singleInstance: true,
    );

    final briteDb = BriteDatabase(database);

    // await briteDb.execute(initScript[0]);
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(briteDb);
  }

  _onCreateDB(Database db, int version) {
    //print("_onCreateDB==${db?.path} $version");
    // db.execute(script));
    _initScript.forEach((script) async => await db.execute(script));
    // _initScript.forEach((script) async {
    //   logger.d(script);
    // });
  }

  _onUpgradeDB(Database db, oldVersion, newVersion) async {
    //print("_onUpgradeDB==OldVersion $oldVersion NewVersion $newVersion");
    // if (oldVersion < newVersion) {
    //   _migration_1_5.forEach((script) async => await db.execute(script));
    // }
    // for (var i = oldVersion - 1; i <= newVersion - 1; i++) {
    //   //await db.execute(_migrationScripts[i]);
    //   //_migrationScripts.forEach((script) async => await db.execute(script));
    // }
  }

  removeDataTable({@required String tableName}) async {
    var db = await database;
    await db.delete(tableName);
  }

  Future<int> insertProfile({Profile todo}) async {
    var db = await database;
    return await db.insert(
      ProfileEntity.tableTodo,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateUpdateProfile({Profile todo}) async {
    var db = await database;
    return await db.update(
      ProfileEntity.tableTodo,
      todo.toJson(),
      where: "${ProfileEntity.columnId} = ?",
      whereArgs: [todo.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<dynamic>> getProfileAll({Profile todo}) async {
    var db = await database;
    List<Map> maps = await db.query(
      ProfileEntity.tableTodo,
    );
    List<Profile> todoItemList = [];
    maps.forEach((element) {
      todoItemList.add(
        Profile.fromJson(element),
      );
    });
    return todoItemList;
  }

  Future<List<dynamic>> getProfileByQuery({String text}) async {
    var db = await database;
    List<Map> maps = await db.query(
      ProfileEntity.tableTodo,
      where:
          "${ProfileEntity.columnFirstName} LIKE ? OR ${ProfileEntity.columnLastName} LIKE ?",
      whereArgs: ['%$text%', '%$text%'],
    );
    List<Profile> todoItemList = [];
    maps.forEach((element) {
      todoItemList.add(
        Profile.fromJson(element),
      );
    });
    return todoItemList;
  }

  Future<List<dynamic>> getTodoDoneAll() async {
    var db = await database;
    List<Map> maps = await db.query(
      ProfileEntity.tableTodo,
      where: "${ProfileEntity.columnAge} = ?",
      whereArgs: [1],
    );
    List<Profile> todoItemList = [];
    maps.forEach((element) {
      todoItemList.add(
        Profile.fromJson(element),
      );
    });
    return todoItemList;
  }

  Future<int> deleteProfile(int id) async {
    var db = await database;
    return await db.delete(
      ProfileEntity.tableTodo,
      where: "${ProfileEntity.columnId} = ?",
      whereArgs: [id],
    );
  }

  // Future<Resource> getWorkoutListFromDb({DateTime dateTime}) async {
  //   var db = await database;
  //   /**
  //    SELECT SUM (burn), (SELECT MIN(createdAt) FROM Workout WHERE createdAt BETWEEN '2020-12-13' AND '2020-12-13T23:59:59' AND LevelId = 1 ORDER BY createdAt ),(SELECT MAX(updatedAt) FROM Workout WHERE createdAt BETWEEN '2020-12-13' AND '2020-12-13T23:59:59' AND LevelId = 1 ORDER BY createdAt
  //   ) FROM Workout WHERE createdAt BETWEEN '2020-12-13' AND '2020-12-13T23:59:59' AND LevelId = 1 ORDER BY createdAt
  //    */

  //   List<Map> queryResult = await db.rawQuery('''
  //     SELECT * FROM ${LevelEntity.tableLevel}
  //   ''');
  //   //logger.wtf(queryResult);

  //   List<Workout> workoutResult = List<Workout>();
  //   await Future.forEach(queryResult, (e) async {
  //     var id = e["id"];
  //     var startDate = Utils.dateFormat.format(dateTime);
  //     var endDate = "${startDate}T23:59:59";
  //     List<Map> result = await db.rawQuery('''
  //         SELECT
  //           LevelId as levelId,
  //           SUM (burn) as burn,
  //           (SELECT MIN(createdAt) FROM Workout WHERE createdAt BETWEEN '$startDate' AND '$endDate' AND LevelId = $id ORDER BY createdAt ) as createdAt,
  //           (SELECT MAX(updatedAt) FROM Workout WHERE createdAt BETWEEN '$startDate' AND '$endDate' AND LevelId = $id ORDER BY createdAt ) as updatedAt
  //         FROM Workout WHERE createdAt BETWEEN '$startDate' AND '$endDate' AND LevelId = $id ORDER BY createdAt
  //       ''');
  //     if (result[0]["levelId"] != null) {
  //       Workout workout = Workout(
  //           levelId: result[0]["levelId"],
  //           name: e["name"],
  //           createdAt: result[0]["createdAt"],
  //           updatedAt: result[0]["updatedAt"],
  //           burn: result[0]["burn"]);
  //       workoutResult.add(workout);
  //     }
  //   });
  //   //logger.d(workoutResult[0].name);
  //   if (workoutResult.isEmpty) {
  //     return Resource(data: null, status: Status.EMPTY);
  //   } else {
  //     return Resource(data: workoutResult, status: Status.SUCCESS);
  //   }
  // }

  // insertProfilePlan({ProfilePlan profilePlan}) async {
  //   var db = await database;
  //   profilePlan?.planLevels?.forEach((e) async {
  //     await db.rawInsert('''
  //       INSERT OR REPLACE INTO ${PlanLevelEntity.tablePlanLevels}
  //       (
  //         ${PlanLevelEntity.columnId} ,
  //         ${PlanLevelEntity.columnWeekday} ,
  //         ${PlanLevelEntity.columnCreatedAt} ,
  //         ${PlanLevelEntity.columnUpdatedAt} ,
  //         ${PlanLevelEntity.columnPlanId} ,
  //         ${PlanLevelEntity.columnLevelId} ,
  //         ${PlanLevelEntity.columnLevel}
  //       ) VALUES(?,?,?,?,?,?,?)
  //   ''', [
  //       e.id,
  //       e.weekday,
  //       e.createdAt,
  //       e.updatedAt,
  //       e.planId,
  //       e.levelId,
  //       e.level.toJson()
  //     ]);
  //   });

  //   profilePlan?.planLevels?.forEach((e) async {
  //     db.rawInsert('''
  //     INSERT OR REPLACE INTO ${LevelEntity.tableLevel}
  //     (
  //       ${LevelEntity.columnId} ,
  //       ${LevelEntity.columnName} ,
  //       ${LevelEntity.columnLevel} ,
  //       ${LevelEntity.columnDetail} ,
  //       ${LevelEntity.columnUnitName} ,
  //       ${LevelEntity.columnUnitValue} ,
  //       ${LevelEntity.columnTime} ,
  //       ${LevelEntity.columnBurnrate} ,
  //       ${LevelEntity.columnMets},
  //       ${LevelEntity.columnLevelConstant},
  //       ${LevelEntity.columnCreatedAt} ,
  //       ${LevelEntity.columnUpdatedAt} ,
  //       ${LevelEntity.columnPostureId} ,
  //       ${LevelEntity.columnPosture}
  //     ) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)
  //     ''', [
  //       e.level.id,
  //       e.level.name,
  //       e.level.level,
  //       e.level.detail,
  //       e.level.unitName,
  //       e.level.unitValue,
  //       e.level.time,
  //       e.level.burnrate,
  //       e.level.mets,
  //       e.level.levelconstant,
  //       e.level.createdAt,
  //       e.level.updatedAt,
  //       e.level.postureId,
  //       e.level.posture.toJson(),
  //     ]);
  //   });
  //   // var result = await db.insert("image_path", imagePath.toJson());
  //   // print(result);
  // }

  // insertHealthDataPoint({List<HealthDataPoint> healthDataPointList}) async {
  //   var db = await database;
  //   healthDataPointList?.forEach((e) async {
  //     await db.rawInsert('''
  //       INSERT OR REPLACE INTO ${HealthDataPointEntity.tableHealthDataPoint}
  //       (
  //         ${HealthDataPointEntity.columnValue} ,
  //         ${HealthDataPointEntity.columnUnit} ,
  //         ${HealthDataPointEntity.columnDateFrom} ,
  //         ${HealthDataPointEntity.columnDateTo} ,
  //         ${HealthDataPointEntity.columnDataType} ,
  //         ${HealthDataPointEntity.columnPlatformType},
  //         ${HealthDataPointEntity.columnDeviceId}
  //       ) VALUES(?,?,?,?,?,?,?)
  //     ''', [
  //       e.value,
  //       e.unit.asString(),
  //       Utils.dateTimeFormat.format(e.dateFrom),
  //       Utils.dateTimeFormat.format(e.dateTo),
  //       e.type.asString(),
  //       e.platform.asString(),
  //       e.deviceId
  //     ]);
  //   });
  // }

  // Future<Resource> getHealthDataPointFromDb({DateTime dateTime}) async {
  //   var db = await database;
  //   var startDate = Utils.dateFormat.format(dateTime);
  //   var endDate = "$startDate 23:59:59";
  //   List<Map> result = await db.rawQuery('''
  //     SELECT SUM(value) as value,unit,(SELECT MIN(dateFrom) FROM HealthDataPoint) as dateFrom ,(SELECT MAX(dateTo) FROM HealthDataPoint) as dateTo,dataType,platformType,deviceId
  //     FROM HealthDataPoint WHERE dateFrom BETWEEN '$startDate' AND '$endDate' GROUP BY unit
  //   ''');
  //   // print("QueryResult==${result?.toString()}");
  //   // print("Result==${result?.toString()}");
  //   var activity = Activity();
  //   if (result.isNotEmpty) {
  //     var dateFrom = DateTime.tryParse(result[0]['dateFrom']);
  //     var dateTo = DateTime.tryParse(result[0]['dateTo']);
  //     var duration = dateTo.difference(dateFrom);
  //     activity.timeMin = Utils.parseDurationToString(duration);
  //     result.forEach((element) {
  //       if (element['unit'] == "CALORIES") {
  //         if (element['value'] == null || element['value'] == '') {
  //           activity.burnKcal = 0;
  //         } else {
  //           activity.burnKcal = element['value'];
  //         }
  //       } else if (element['unit'] == "COUNT") {
  //         activity.distanceM = element['value'] * 0.762;
  //       }
  //     });
  //     //print(activity?.toJson());
  //     return Resource(data: activity, status: Status.SUCCESS);
  //   } else {
  //     return Resource(data: null, status: Status.EMPTY);
  //   }
  // }

}
