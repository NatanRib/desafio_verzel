import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:verzel_teste/app/controller/user_controller.dart';
import 'package:verzel_teste/app/models/todo_model.dart';
import 'package:verzel_teste/app/modules/home/controller/home_controller.dart';
import 'package:verzel_teste/app/repository/todo_repository.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';

class TodoController extends GetxController {

final uniCustomWidgets = Get.put(UniCustomWidgets());
final homeController = Get.put(HomeController());
final TodoRepository repository;
TodoController({@required this.repository}) : assert(repository != null);

  List<TodoModel> todos;

  onInit(){
    print('init todo controller');
    getAllTodosOfUser();
    super.onInit();
  }

  createTodo(TodoModel todo)async{
    int id = await repository.createTodo(todo);
    if (!id.isNull){
      homeController.crearTextControllers();
      uniCustomWidgets.snackbar(
        'Tarefa criada!', 
        '', 
        true, 
        2
      );
      getAllTodosOfUser();
    }else{
      uniCustomWidgets.snackbar(
        'Erro ao criar tarefa', 
        '', 
        false, 
        2
      );
    }
  }

  updateTodo(TodoModel todo)async{
    print('controlel -> todo id: ${todo.id}');
    await repository.updateTodo(todo).then((value) {
      print('controller recebeu value $value');
      if (value != 0){
        uniCustomWidgets.snackbar(
          'Tarefa atualizada', 
          '', 
          true, 
          2
        );
        getAllTodosOfUser();
      }else{
        uniCustomWidgets.snackbar(
          'Erro ao atualizar terefa', 
          '', 
          false, 
          2
        );
      }
    });
  }

  deletaTodo(TodoModel todo)async{
    print('controller deletando todo');
    await repository.deleteTodo(todo).then((value) {
      print('value recebudo $value');
      if (value == 0){
        uniCustomWidgets.snackbar(
          'Erro ao deletar tarefa', 
          '', 
          false, 
          2
        );
      }else{
        getAllTodosOfUser();
        uniCustomWidgets.snackbar(
          'Tarefa deletada', 
          '', 
          true, 
          2
        );
      }
    });
  }

  getAllTodosOfUser()async{
    print('current user id: ${UserController.CURRENT_USER.id}');
    todos = await repository.getTodo(UserController.CURRENT_USER);
    if (todos == null){
      uniCustomWidgets.snackbar(
        'Erro ao recuperar tarefas', 
        '', 
        false, 
        2
      );
    }else if (todos.isEmpty){
      update();
    }else{
      update();
    }
    
  }

  onClose(){
    print('deletando todo controller');
    super.onClose();
  }
}