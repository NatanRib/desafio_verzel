import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:verzel_teste/app/models/user_model.dart';
import 'package:verzel_teste/app/modules/home/ui/home_page.dart';
import 'package:verzel_teste/app/modules/login/ui/login_page.dart';
import 'package:verzel_teste/app/repository/user_repository.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';

class UserController extends GetxController {

  final UserRepository repository;
  final uniCustomWidgets = Get.put(UniCustomWidgets());
  static UserModel CURRENT_USER = null;
  UserController({@required this.repository}) : assert(repository != null);

  saveUser(UserModel user)async{
    await repository.createUser(user).then((value) {
      if (value.isNull || value == 0){
        uniCustomWidgets.snackbar(
          'Erro ao tentar criar usuario', 
          '',
          false,
          3
        );
      }else{
        print(value.toString());
        uniCustomWidgets.snackbar(
          'Usuario criado com sucesso', 
          '',
          true,
          3
        );
      }
    });
  }

  Future<bool> userAuth(UserModel user)async{
    UserModel userAuth = await repository.loginUser(user);
    print('cotroller value ${userAuth.toString()}');
    if (userAuth.isNull){
      uniCustomWidgets.snackbar('Usuario não existe', '', false, 3);
      return false;
    }else{
      CURRENT_USER = userAuth;
      print('current user ${CURRENT_USER.nome}');
      return true;
    }
  }

  //apagar isso
  deletaDataBase(){
    repository.deletaDb();
  }
}