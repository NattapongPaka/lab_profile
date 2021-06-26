import 'package:flutter/material.dart';

/**
    this.id,
    this.firstName,
    this.lastName,
    this.birthDay,
    this.address,
    this.gender,
    this.phone,
    this.email,
    this.age,
    this.company,
    this.picture,
 */

class ProfileEntity {
  ProfileEntity._();

  static final tableTodo = "Profile";

  static final columnId = "id";
  static final columnFirstName = "first_name";
  static final columnLastName = "last_name";
  static final columnBirthDay = "birth_day";
  static final columnAddress = "address";
  static final columnGender = "gender";
  static final columnPhone = "phone";
  static final columnEmail = "email";
  static final columnAge = "age";
  static final columnCompany = "company";
  static final columnPicture = "picture";

  static final createTable = '''
  CREATE TABLE IF NOT EXISTS $tableTodo (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnFirstName TEXT,
    $columnLastName TEXT,
    $columnBirthDay INTEGER,
    $columnAddress TEXT,
    $columnGender TEXT,
    $columnEmail TEXT,
    $columnPhone TEXT,
    $columnAge TEXT,
    $columnCompany TEXT,
    $columnPicture TEXT
  );
  ''';
}

// class ProfilePlanEntity {
//   static final tableProfilePlan = "ProfilePlan";
//   static final columnId = "id";
//   static final columnName = "name";
//   static final columnType = "type";
//   static final columnDetail = "detail";
//   static final columnCreateAt = "createdAt";
//   static final columnUpdateAt = "updatedAt";
//   //static final columnUserId = "userId";
//   //static final columnPlanLevel = "planLevel";
//   static final createTable = '''
//   CREATE TABLE IF NOT EXISTS $tableProfilePlan (
//     $columnId INTEGER PRIMARY KEY,
//     $columnName TEXT,
//     $columnType TEXT,
//     $columnDetail TEXT,
//     $columnCreateAt TEXT,
//     $columnUpdateAt TEXT
//   );
//   ''';
//   /**
//     int id;
//     String name;
//     String type;
//     String detail;
//     String createdAt;
//     String updatedAt;
//     int userId;
//     List<PlanLevel> planLevels;
//    */
// }

// class PlanLevelEntity {
//   static final tablePlanLevels = "PlanLevel";
//   static final columnId = "id";
//   static final columnWeekday = "weekday";
//   static final columnOrder = "order";
//   static final columnCreatedAt = "createAt";
//   static final columnUpdatedAt = "updatedAt";
//   static final columnPlanId = "planId";
//   static final columnLevelId = "levelId";
//   static final columnLevel = "level";
//   static final createTable = '''
//   CREATE TABLE IF NOT EXISTS $tablePlanLevels (
//     $columnId INTEGER PRIMARY KEY,
//     $columnWeekday TEXT,
//     $columnCreatedAt TEXT,
//     $columnUpdatedAt TEXT,
//     $columnPlanId INTEGER,
//     $columnLevelId INTEGER,
//     $columnLevel TEXT
//   );
//   ''';
//   /**
//     int id;
//     String weekday;
//     int order;
//     String createdAt;
//     String updatedAt;
//     int planId;
//     int levelId;
//     LevelModel level;
//    */
// }

// class LevelEntity {
//   static final tableLevel = "Level";
//   static final columnId = "id";
//   static final columnName = "name";
//   static final columnLevel = "level";
//   static final columnDetail = "detail";
//   static final columnUnitName = "unit_name";
//   static final columnUnitValue = "unit_value";
//   static final columnTime = "time";
//   static final columnBurnrate = "burnrate";
//   static final columnMets = "mets";
//   static final columnLevelConstant = "levelconstant";
//   static final columnCreatedAt = "createdAt";
//   static final columnUpdatedAt = "updatedAt";
//   static final columnPostureId = "postureId";
//   static final columnPosture = "posture";

//   static final createTable = '''
//   CREATE TABLE IF NOT EXISTS $tableLevel (
//     $columnId INTEGER PRIMARY KEY,
//     $columnName TEXT,
//     $columnLevel TEXT,
//     $columnDetail TEXT,
//     $columnUnitName TEXT,
//     $columnUnitValue NUMERIC,
//     $columnTime TEXT,
//     $columnBurnrate NUMERIC,
//     $columnMets NUMERIC,
//     $columnLevelConstant NUMERIC,
//     $columnCreatedAt TEXT,
//     $columnUpdatedAt TEXT,
//     $columnPostureId INTEGER,
//     $columnPosture TEXT
//   );
//   ''';
//   /**
//     int id,
//     String name,
//     String level,
//     String detail,
//     String unitName,
//     int unitValue,
//     String time,
//     int burnrate,
//     double mets,
//     double levelconstant,
//     String createdAt,
//     String updatedAt,
//     int postureId,
//     Posture posture,
//     bool isSelection,
//    */
// }

// class WorkoutEntity {
//   static final tableWorkout = "Workout";
//   static final columnId = "id";
//   static final columnBurn = "burn";
//   static final columnCreatedAt = "createdAt";
//   static final columnUpdatedAt = "updatedAt";
//   static final columnDate = "date";
//   static final columnUserId = "UserId";
//   static final columnLevelId = "LevelId";
//   static final columnPlanId = "PlanId";

//   static final createTable = '''
//   CREATE TABLE IF NOT EXISTS $tableWorkout (
//     $columnId INTEGER PRIMARY KEY,
//     $columnBurn NUMERIC,
//     $columnCreatedAt TEXT,
//     $columnUpdatedAt TEXT,
//     $columnDate TEXT,
//     $columnUserId INTEGER,
//     $columnLevelId INTEGER,
//     $columnPlanId INTEGER
//   );
//   ''';
//   /**
//         "id": 204,
//         "burn": 200.1,
//         "createdAt": "2020-12-19T12:20:02.798Z",
//         "updatedAt": "2020-12-19T12:20:02.798Z",
//         "UserId": 16,
//         "LevelId": 1,
//         "PlanId": 16
//    */
// }

// class HealthDataPointEntity{
//   static final tableHealthDataPoint = "HealthDataPoint";
//   static final columnId = "id";
//   static final columnValue = "value";
//   static final columnUnit = "unit";
//   static final columnDateFrom = "dateFrom";
//   static final columnDateTo = "dateTo";
//   static final columnDataType = "dataType";
//   static final columnPlatformType = "platformType";
//   static final columnDeviceId = "deviceId";

//   static final createTable = '''
//   CREATE TABLE IF NOT EXISTS $tableHealthDataPoint (
//     $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//     $columnValue NUMERIC,
//     $columnUnit TEXT,
//     $columnDateFrom TEXT,
//     $columnDateTo TEXT,
//     $columnDataType TEXT,
//     $columnPlatformType TEXT,
//     $columnDeviceId TEXT
//   );
//   ''';

//   /**
//    {
//     "value":21,
//     "unit":"HealthDataUnit.COUNT",
//     "date_from":"2019-02-15 16:41:31.495",
//     "date_to":"2019-02-15 16:42:06.571",
//     "data_type":"HealthDataType.STEPS",
//     "platform_type":"PlatformType.ANDROID"
//     }
//    */
// }
