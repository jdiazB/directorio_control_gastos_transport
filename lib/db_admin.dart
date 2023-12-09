import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled9_control_gastos/model/modelgastotruck.dart';
import 'package:untitled9_control_gastos/model/modeltruck.dart';

class DBAdmin {
  Database? myDatabase;
  // Database? myDatabasetrabajador;

  //Singleton
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();
  //

  Future<Database?> checkDatabase() async {
    if (myDatabase != null) {
      return myDatabase;
    }
    myDatabase = await initDatabase();
    return myDatabase;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "form4DB.db");
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database dbx, int version) async {
          //CREAR LA TABLA CORRESPONDIENTE
          await dbx.execute(
              "CREATE TABLE FORM(id INTEGER PRIMARY KEY AUTOINCREMENT, tipo TEXT,fecha TEXT, camionId TEXT, trabajadorId TEXT,monto REAL)");
          //CREAR LA TABLA TRABAJADOR
          await dbx.execute(
              "CREATE TABLE TRABAJADOR(id INTEGER PRIMARY KEY AUTOINCREMENT, trabajador TEXT)");
          //CREAR LA TABLA CAMION
          await dbx.execute(
              "CREATE TABLE CAMION(id INTEGER PRIMARY KEY AUTOINCREMENT, camion TEXT)");

        });

  }

  Future<int> insertRawTask(OilExpensive model) async {
    Database? db = await checkDatabase();
    int res = await db!.rawInsert(
        "INSERT INTO FORM(tipo, camionId, trabajadorId, monto, fecha) VALUES ('${model.tipo}','${model.camionId}','${model.trabajadorId}','${model.monto}','${model.fecha}')");
    return res;
  }

  Future<int> insertTask(OilExpensive model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "FORM",
      {
        "tipo": model.tipo,
        "camionId": model.camionId,
        "trabajadorId": model.trabajadorId,
        "monto":model.monto,
        "fecha":model.fecha
      },
    );
    return res;
  }
  Future<int> insertTasktrabajador(Trabajador model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "TRABAJADOR",
      {
        "trabajador": model.trabajador
      },
    );
    return res;
  }
  Future<int> insertTaskcamion(Camion model) async {
    Database? db = await checkDatabase();
    int res = await db!.insert(
      "CAMION",
      {
        "camion": model.camion,

      },
    );
    return res;
  }



  getRawTasks() async {
    Database? db = await checkDatabase();
    List tasks = await db!.rawQuery("SELECT * FROM FORM");
    print(tasks[0]);
  }

  Future<List<OilExpensive>> getTasks() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("FORM");
    List<OilExpensive> taskModelList = tasks.map((e) => OilExpensive.deMapAModel(e)).toList();

    // tasks.forEach((element) {
    //   TaskModel task = TaskModel.deMapAModel(element);
    //   taskModelList.add(task);
    // });
    return taskModelList;
  }

  Future<List<Trabajador>> getTasksTrabajador() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("TRABAJADOR");
    List<Trabajador> list = tasks.map((e) => Trabajador.deMapAModel(e)).toList();

    // tasks.forEach((element) {
    //   TaskModel task = TaskModel.deMapAModel(element);
    //   taskModelList.add(task);
    // });
    return list;
  }

  Future<List<Camion>> getTasksCamion() async {
    Database? db = await checkDatabase();
    List<Map<String, dynamic>> tasks = await db!.query("CAMION");
    List<Camion> list = tasks.map((e) => Camion.deMapAModel(e)).toList();

    // tasks.forEach((element) {
    //   TaskModel task = TaskModel.deMapAModel(element);
    //   taskModelList.add(task);
    // });
    return list;
  }

  updateRawTask() async {
    Database? db = await checkDatabase();
    int res = await db!.rawUpdate(
        "UPDATE FORM SET tipo = 'Ir de compras',  camionId = 'Comprar comida', trabajadorId = 'true' WHERE id = 2");
    print(res);
  }

  Future<int> updateTask(OilExpensive model) async {
    Database? db = await checkDatabase();
    int res = await db!.update(
        "FORM",
        {
          "tipo": model.tipo,
          "camionId": model.camionId,
          "trabajadorId" : model.trabajadorId,
          "monto":model.monto,
          "fecha":model.fecha
        },
        where: "id = ${model.id}"
    );
    return res;
  }

  deleteRawTask() async{
    Database? db = await checkDatabase();
    int res = await db!.rawDelete("DELETE FROM FORM WHERE id = 2");
    print(res);
  }

  Future<int> deleteTask(int id) async{
    Database? db = await checkDatabase();
    int res = await db!.delete("FORM", where: "id = $id");
    return res;
  }



}