import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzel_teste/app/controller/todo_controler.dart';
import 'package:verzel_teste/app/controller/user_controller.dart';
import 'package:verzel_teste/app/models/user_model.dart';
import 'package:verzel_teste/app/modules/home/ui/home_page.dart';
import 'package:verzel_teste/app/modules/login/controller/login_controller.dart';
import 'package:verzel_teste/app/modules/singup/ui/singup_page.dart';
import 'package:verzel_teste/app/repository/user_repository.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';

class LoginPage extends StatelessWidget {

  final _controller = Get.put(LoginController());
  final _userController = Get.put(UserController(repository: UserRepository()), );
  final _formKey = GlobalKey<FormState>();
  final _customWidgets = Get.put(UniCustomWidgets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,
        title: Text('Logar', style: TextStyle(color: Get.theme.accentColor),),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Todo App',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _customWidgets.customTextField(
                          label: 'Nome',
                          hint: 'Abcd',
                          obrigatorio: true,
                          controller: _controller.nome,
                          validator: (value){
                            return  value.isEmpty ? 'este campo nao pode estar vazio' : null;
                          }
                        ),
                        Obx(() => Padding( //senha
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: TextFormField(                      
                            obscureText: _controller.obscureText,
                            controller: _controller.senha,
                            validator: (value){
                              return  value.isEmpty ? 'este campo nao pode estar vazio' : null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: ()=> _controller.obscureText = !_controller.obscureText,
                              ),
                              labelText: 'Senha',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        )),
                        SizedBox(height: 16,),
                        Obx(()=> SizedBox(
                          width: Get.width * 0.5,
                          height: Get.height * 0.08,
                          child: RaisedButton(
                            color: Get.theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                _controller.logando = true;
                                bool auth = await _userController.userAuth(
                                  UserModel(
                                    nome: _controller.nome.text,
                                    senha: _controller.senha.text
                                  )
                                );
                                if (auth) {
                                  _controller.logando = false;
                                  Get.offAll(HomePage());
                                }else{
                                  _controller.logando = false;
                                }
                              }
                            },
                            child: _controller.logando ? 
                             CircularProgressIndicator() :
                             Text(
                              'Login', 
                              style: TextStyle(
                                color: Get.theme.accentColor,
                                fontSize: 18
                              ),
                            ),
                          ),
                        )),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Center(
                              child: Text(
                                'Não tem conta? cadastrar-se',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ),
                          ),
                          onTap: ()=> Get.off(SingUpPage()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),]
        ),
      )
    );
  }
}