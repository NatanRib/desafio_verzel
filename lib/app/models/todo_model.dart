import 'package:flutter/material.dart';

class TodoModel{
  int id;
  String nome;
  DateTime entrega;
  DateTime conclusao;
  String estado;
  int userId;

  TodoModel({this.id, @required this.nome, @required this.entrega,
   this.conclusao, this.estado='Pendente', @required this.userId});

  TodoModel.fromMap(Map map){
    this.id = map['id'];
    this.nome = map['nome'];
    this.entrega = DateTime.parse(map['data_entrega']).toLocal();
    this.conclusao = map['data_conclusao'] == 'null' ?
     null :
     DateTime.parse(map['data_conclusao']).toLocal();
    this.estado = map['estado'];
    this.userId = map['user_id'];
  }

  toMap(){
    return{
      'id' : this.id,
      'nome': this.nome,
      'data_entrega': this.entrega.toString(),
      'data_conclusao': this.conclusao == null? 'null' : this.conclusao.toString(),
      'estado' : this.estado,
      'user_id': this.userId 
    };
  }
}