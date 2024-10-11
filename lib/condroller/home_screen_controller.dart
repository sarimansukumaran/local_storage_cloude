import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class HomeScreenController {
  static late Database myDatabase;
  static List<Map> employeedatalist = [];

  static Future initDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    myDatabase = await openDatabase("EmployeeData.db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future addEmployee(String employeeName, String designation) async {
    await myDatabase.rawInsert(
        'INSERT INTO Employees(name, designation) VALUES(?,?)',
        [employeeName, designation]); //? is no of values
    getEmployee();
  }

  static Future getEmployee() async {
    employeedatalist = await myDatabase.rawQuery('SELECT * FROM Employees');
    print(employeedatalist);
  }

  static Future removeEmployee(int empid) async {
    int count = await myDatabase
        .rawDelete('DELETE FROM Employees WHERE id = ?', [empid]);
    getEmployee();
  }

  updateEmployee() {}
}
