import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:verzel_teste/app/models/todo_model.dart';
import 'package:verzel_teste/app/modules/home/controller/home_controller.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';
import 'package:get/get.dart';

class HomeWidgets{

  final uniCustomWidgets = Get.put(UniCustomWidgets());
  final _homeController = Get.put(HomeController());

  Widget newTodo({nomeController, 
    entregaController,
    entrega,
    conclusaoController, 
    conclusao, 
    Function createTodo}){

    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: Text('Nova Tarefa'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              uniCustomWidgets.customTextField(
                hint: 'Acbde',
                label: 'Nome',
                controller: nomeController,
                obrigatorio: true,
                validator: (value){
                  if(value == ''){
                    return 'Esse campo nao pode estar vazio';
                  }
                  return null;
                }
              ),
              uniCustomWidgets.customTextField(
                hint: '99/99/9999 99:99',
                label: 'Data da entrega',
                controller: entregaController,
                obrigatorio: true,
                keyBoarType: TextInputType.number,
                mask: '99/99/9999 99:99',
                validator: (String value){
                  if(value.isEmpty){
                    return 'Esse campo nao pode estar vazio';
                  }
                  if (value.length < 16){
                    return 'Faltam dados nessa data';
                  }
                  if (int.parse(value.substring(3, 5)) >12){
                    return 'Mês não pode ser maior que 12';
                  }
                  if (int.parse(value.substring(0, 2)) > 31){
                    return 'Dia não pode ser maior que 31';
                  }
                  return null;
                }
              ),
              uniCustomWidgets.customTextField(
                hint: '99/99/9999 99:99',
                label: 'Data do termino (opcional)',
                controller: conclusaoController,
                obrigatorio: false,
                keyBoarType: TextInputType.number,
                mask: '99/99/9999 99:99',
                validator: (String value){
                  if(value.isEmpty){
                    return null;
                  }
                  else{
                    if (value.length < 16){
                      return 'Faltam dados nessa data';
                    }
                    if (int.parse(value.substring(3, 5)) >12){
                      return 'Mês não pode ser maior que 12';
                    }
                    if (int.parse(value.substring(0, 2)) > 31){
                      return 'Dia não pode ser maior que 31';
                    }
                  }
                }
              ),
            ],
          )
        ),
      ),
      actions: [
        RaisedButton(
          onPressed: ()=> Get.back(),
          child: Text('Cancelar',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        RaisedButton(
          onPressed: (){
            if(_formKey.currentState.validate()){
              createTodo();
              
              Get.back();
            }
          },
          child: Text('Salvar',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        )
      ],
    );
  }

  Widget cardTodo(TodoModel todo, Function done, Function edit, Function delete){
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 5,
      color: Colors.white,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        title: Text('${todo.id} - ${todo.nome}'),
        trailing:  Container(
          width: Get.width * 0.3,
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.10,
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.done, color: Colors.green[700],), 
                  onPressed: ()=> done()
                ),
              ),
              SizedBox(
                width: Get.width * 0.10,
                child: IconButton(
                  iconSize: 25,
                  icon: Icon(Icons.edit, color: Colors.yellow[800],), 
                  onPressed: ()=> edit()
                ),
              ),
              SizedBox(
                width: Get.width * 0.10,
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.remove, color: Colors.red[700],), 
                  onPressed: ()=> delete()
                ),
              ),
            ],
          ),
        ), 
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.estado,
              style: TextStyle(
                color: todo.estado == 'Pendente' ?
                Colors.yellow[800] :
                Colors.green[800]
              ),
            ),
            Text('Entrega: ${todo.entrega.day}/'+
              '${todo.entrega.month}/${todo.entrega.year}'+
              ' ${todo.entrega.toString().substring(11,13)}:' +
              '${todo.entrega.toString().substring(14,16)}',
              style: TextStyle(
                fontSize: 13
              ),
            ),
            todo.conclusao != null ?
            Text('Conclusão: ${todo.conclusao.day}/'+
              '${todo.conclusao.month}/${todo.conclusao.year}' +
              ' ${todo.conclusao.toString().substring(11,13)}:' +
              '${todo.conclusao.toString().substring(14,16)}',
              style: TextStyle(
                fontSize: 13
              ),
            ) : Container()
          ],
        ),
      )
    );
  }

  final _editFormKey = GlobalKey<FormState>();

  Widget editTodo(TextEditingController nome,
   TextEditingController entrega, TextEditingController conclusao,
   Function editTodo){
    return AlertDialog(
      title:  Text('Editar tarefa'),
      content: SingleChildScrollView(
        child: Form(
          key: _editFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              uniCustomWidgets.customTextField(
                hint: 'Acbde',
                label: 'Nome',
                controller: nome,
                obrigatorio: true,
                validator: (value){
                  if(value == ''){
                    return 'Esse campo nao pode estar vazio';
                  }
                  return null;
                }
              ),
              uniCustomWidgets.customTextField(
                hint: '99/99/9999 99:99',
                label: 'Data da entrega',
                controller: entrega,
                obrigatorio: true,
                keyBoarType: TextInputType.number,
                mask: '99/99/9999 99:99',
                validator: (String value){

                  print(DateTime.now().toLocal());

                  if(value.isEmpty){
                    return 'Esse campo nao pode estar vazio';
                  }
                  if (value.length < 16){
                    return 'Faltam dados nessa data';
                  }
                  if (int.parse(value.substring(3, 5)) >12){
                    return 'Mês não pode ser maior que 12';
                  }
                  if (int.parse(value.substring(0, 2)) > 31){
                    return 'Dia não pode ser maior que 31';
                  }
                  return null;
                }
              ),
              uniCustomWidgets.customTextField(
                hint: '99/99/9999 99:99',
                label: 'Data do termino (opcional)',
                controller: conclusao,
                obrigatorio: false,
                keyBoarType: TextInputType.number,
                mask: '99/99/9999 99:99',
                validator: (String value){
                  if(value.isEmpty){
                    return null;
                  }
                  else{
                    if (value.length < 16){
                      return 'Faltam dados nessa data';
                    }
                    if (int.parse(value.substring(3, 5)) >12){
                      return 'Mês não pode ser maior que 12';
                    }
                    if (int.parse(value.substring(0, 2)) > 31){
                      return 'Dia não pode ser maior que 31';
                    }
                  }
                }
              ),
            ],
          )
        ),
      ),
      actions: [
        RaisedButton(
          onPressed: (){
            Get.back();
            _homeController.crearTextControllers();
          },
          child: Text('Cancelar',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        RaisedButton(
          onPressed: (){
            if(_editFormKey.currentState.validate()){
              editTodo();
              _homeController.crearTextControllers();
              Get.back();
            }
          },
          child: Text('Salvar',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        )
      ],
    );
  }        
}