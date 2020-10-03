import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:verzel_teste/app/models/todo_model.dart';
import 'package:verzel_teste/app/models/user_model.dart';

class ApiDb{

  Database _db;
  final String _userTableName = 'users';
  final String _todoTableName = 'todos';

  ApiDb(){
    startDatabase();
  }

  void startDatabase()async{
    try{
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sqlite.db');
      _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_userTableName (id INTEGER PRIMARY KEY, nome TEXT, email TEXT,'+
              ' data_nascimento TEXT, cpf TEXT, cep TEXT, endereco TEXT, numero TEXT, senha TEXT)');
          await db.execute(
              'CREATE TABLE $_todoTableName (id INTEGER PRIMARY KEY, nome TEXT, data_entrega TEXT,'+
              ' data_conclusao TEXT, estado TEXT, user_id REFERENCES users(id))');
          
        },
        onConfigure:(_db) => _db.execute('PRAGMA foreign_keys = ON')
      );
    }catch(e){
      print(e.toString());
    }
  }

  Future<int> updateTodo(Map map)async{
    try{
      return await _db.update(
        _todoTableName,
        map,
        where: 'id = ?',
        whereArgs: [map['id']]
      );
    }catch(e){
      print(e.toString());
      return 0;
    }
  }

  Future<int> deleteTodo(Map map)async{
    try{
      return await _db.delete(
        _todoTableName,
        where: 'id = ?',
        whereArgs: [map['id']]
      );
    }catch(e){
      print(e.toString());
      return 0;
    }
  }

  void closeDatabase()async{
    try{
      await _db.close();
    }catch(e){
      print(e.toString());
    }
  }

  Future<int> createUser(UserModel user)async{
    try{
      return await _db.insert(_userTableName, user.toMap());
    }catch(e){
      print(e.toString());
    }
    return 0;
  }

  void deleteDb()async{
    try{
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'sqlite.db');
      await deleteDatabase(path);
      startDatabase();
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<Map<String,dynamic>>> loginUser(String nome, String senha)async{
    try{
      var lista = await _db.query(
        _userTableName, 
        where: 'nome = ? AND senha = ?', 
        whereArgs: [nome, senha]
      );
      if (lista == null){
        return null;
      }
      if (lista.isEmpty){
        return null;
      }else{
        return lista;
      }
    }catch(e){
      print('erro ${e.toString()}');
      return[];
    }
  }

  Future<List<Map<String,dynamic>>> getTodo(int userId)async{
    try{
      List lista = await _db.query(
        _todoTableName,
        where: 'user_id = ?',
        whereArgs: [userId]
      );
      return lista;
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future<int> createTodo(TodoModel todo) async{
    try{
      int id = await _db.insert(_todoTableName, todo.toMap());
      return id;
    }catch(e){
      print(e);
    }
    return 0;
  }
}