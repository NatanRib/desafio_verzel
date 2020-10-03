import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:verzel_teste/app/api/api_db.dart';
import 'package:verzel_teste/app/models/todo_model.dart';
import 'package:verzel_teste/app/models/user_model.dart';

class TodoRepository{
  final api = Get.put(ApiDb());

  Future<List<TodoModel>> getTodo(UserModel currentUser)async{
    List<Map<String,dynamic>> lista = await api.getTodo(currentUser.id);
    if (lista == null){
      return null;
    }
    if (lista.isEmpty){
      return [];
    }
    List<TodoModel> todos = List(); 
    for (Map m in lista){
      todos.add(TodoModel.fromMap(m));
    }
    return todos;
  }

  Future<int> createTodo(TodoModel todo)async{
    int id = await api.createTodo(todo);
    return id;
  }

  Future<int> updateTodo(TodoModel todo)async{
    int idUpdate = await api.updateTodo(todo.toMap());
    return idUpdate;
  }

  Future<int> deleteTodo(TodoModel todo)async{
    int qtDeleted = await api.deleteTodo(todo.toMap());
    return qtDeleted;
  }
}