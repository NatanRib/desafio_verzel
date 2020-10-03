import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzel_teste/app/controller/todo_controler.dart';
import 'package:verzel_teste/app/controller/user_controller.dart';
import 'package:verzel_teste/app/models/todo_model.dart';
import 'package:verzel_teste/app/modules/home/controller/home_controller.dart';
import 'package:verzel_teste/app/modules/home/ui/widgets/home_widgets.dart';
import 'package:verzel_teste/app/modules/login/ui/login_page.dart';
import 'package:verzel_teste/app/repository/todo_repository.dart';

class HomePage extends StatelessWidget {

  final _todoController = Get.put(TodoController(repository: TodoRepository()));
  final _controller = Get.put(HomeController());
  final _homeWidgets = Get.put(HomeWidgets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            UserController.CURRENT_USER = null;
            Get.delete<TodoController>();
            Get.offAll(LoginPage());
          }
        ),
        title: Text('Tarefas de ${UserController.CURRENT_USER.nome}'),
        centerTitle: true,
      ),
      body: GetBuilder<TodoController>(
        builder: (_) => _.todos.isNull || _.todos.isEmpty ? 
        Center(child: Text('Lista de tarefas vazia'),) :
        Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: ListView.builder(
            itemCount: _.todos.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  _homeWidgets.cardTodo(
                    _.todos[index],
                    (){
                      var todoDone = _.todos[index];
                      todoDone.estado = 'Concluido'; 
                      _todoController.updateTodo(todoDone);
                    },
                    (){
                      _controller.nome.text = _.todos[index].nome;
                      _controller.entrega.text = 
                      '${_.todos[index].entrega.toString().substring(8,10)}' +
                      '/${_.todos[index].entrega.toString().substring(5,7)}'+
                      '/${_.todos[index].entrega.toString().substring(0,4)} '+
                      '${_.todos[index].entrega.toString().substring(11,13)}:'+
                      '${_.todos[index].entrega.toString().substring(14,16)}';
                      _.todos[index].conclusao == null ?
                         _controller.conclusao.text = '' : 
                         _controller.conclusao.text = 
                          '${_.todos[index].conclusao.toString().substring(8,10)}' +
                          '/${_.todos[index].conclusao.toString().substring(5,7)}'+
                          '/${_.todos[index].conclusao.toString().substring(0,4)} '+
                          '${_.todos[index].conclusao.toString().substring(11,13)}:'+
                          '${_.todos[index].conclusao.toString().substring(14,16)}';
                      Get.dialog(
                        _homeWidgets.editTodo(
                          _controller.nome, 
                          _controller.entrega, 
                          _controller.conclusao,
                          () => _todoController.updateTodo(
                            TodoModel(
                              nome: _controller.nome.text,
                              entrega: DateTime.parse(
                                '${_controller.entrega.text.substring(6,10)}'+
                                '-${_controller.entrega.text.substring(3,5)}'+
                                '-${_controller.entrega.text.substring(0,2)} ' +
                                '${_controller.entrega.text.substring(11,13)}:'+
                                '${_controller.entrega.text.substring(14,16)}'
                              ),
                              conclusao: _controller.conclusao.text == '' ? 
                               null : DateTime.parse(
                                 '${_controller.conclusao.text.substring(6,10)}'+
                                '-${_controller.conclusao.text.substring(3,5)}'+
                                '-${_controller.conclusao.text.substring(0,2)} ' +
                                '${_controller.conclusao.text.substring(11,13)}:'+
                                '${_controller.conclusao.text.substring(14,16)}'
                               ),
                              userId: _.todos[index].userId,
                              estado: _.todos[index].estado,
                              id: _.todos[index].id
                            )
                          ),
                        ),
                        barrierDismissible: false
                      );
                    },
                    (){
                      _todoController.deletaTodo(_.todos[index]);
                    }
                  ),
                  SizedBox(height: 8,)
                ],
              );
            }
          ),
        ),
      ), 
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(Icons.add_circle_outline),
        onPressed: (){ 
          Get.dialog(
            _homeWidgets.newTodo(
              nomeController: _controller.nome, 
              entregaController: _controller.entrega, 
              conclusaoController: _controller.conclusao,
              createTodo: ()=> _todoController.createTodo(
                TodoModel(
                  nome: _controller.nome.text,
                  entrega: _controller.parseDate(_controller.entrega.text).toLocal(), 
                  conclusao: _controller.conclusao.text == '' ? null :
                    _controller.parseDate(_controller.conclusao.text).toLocal(),
                  userId: UserController.CURRENT_USER.id
                )
              )
            ),
            barrierDismissible: false,
          );
        }
      ),
    );
  }
}