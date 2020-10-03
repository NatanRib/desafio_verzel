import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:verzel_teste/app/api/api_db.dart';
import 'package:verzel_teste/app/models/user_model.dart';

class UserRepository{

  final api = Get.put(ApiDb());

  Future<int> createUser(UserModel user)async{
    return await api.createUser(user);
  }

//apagar essa funcao
  deletaDb(){
    api.deleteDb();
  }

  Future<UserModel> loginUser(UserModel user)async{
    List users = await api.loginUser(user.nome, user.senha);
    if (users == null){
      return null;
    }
    if (users.isNotEmpty){
      UserModel userAuth = UserModel.fromMap(users[0]);
      return userAuth;
    }
    return null;
  }
}