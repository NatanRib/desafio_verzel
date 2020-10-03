import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzel_teste/app/controller/user_controller.dart';
import 'package:verzel_teste/app/models/user_model.dart';
import 'package:verzel_teste/app/modules/login/controller/login_controller.dart';
import 'package:verzel_teste/app/modules/login/ui/login_page.dart';
import 'package:verzel_teste/app/modules/singup/repository/endereco_repository.dart';
import 'package:verzel_teste/app/repository/user_repository.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';
import '../service/api_cep.dart';
import '../controller/singup_controller.dart';

class SingUpPage extends StatelessWidget {
  
  final _controller = Get.put(SingUpController(
    repository: EnderecoRepository(serviceCep: ApiCep()))
  );
  final _userController = Get.put(UserController(
    repository: UserRepository()
  ));
  final _formKey = GlobalKey<FormState>();
  final _customWidgets = Get.put(UniCustomWidgets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
        centerTitle: true,
        backgroundColor: Get.theme.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Get.delete<SingUpController>();
            Get.off(LoginPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _customWidgets.customTextField(
                      label: 'Nome',
                      hint: 'Joao',
                      obrigatorio: true,
                      controller: _controller.nome,
                      validator: (value){
                        return  value.isEmpty ? 'este campo nao pode estar vazio' : null;
                      }
                    ),
                  ),
                  _customWidgets.customTextField(
                    label: 'Email',
                    hint: 'aa@aaa.com',
                    obrigatorio: true,
                    controller: _controller.email,
                    validator: (value){
                      return  value.isEmpty ? 'este campo nao pode estar vazio' : null;
                    }
                  ),
                  _customWidgets.customTextField(
                    label: 'Data de nascimento',
                    hint: '99/99/9999',
                    obrigatorio: true,
                    controller: _controller.dataNasciemnto,
                    keyBoarType: TextInputType.number,
                    mask: '99/99/9999',
                    validator: (String value){
                      return _controller.validaIdade(value);
                    }
                  ),
                  _customWidgets.customTextField(
                    label: 'Cpf',
                    hint: '999.999.999-99',
                    controller: _controller.cpf,
                    mask: '999.999.999-99',
                    keyBoarType: TextInputType.number,
                    validator: (String value){
                      return _controller.validaCpf(value);
                    }
                  ),
                  _customWidgets.customTextField(
                    label: 'Cep',
                    hint: '99999-999',
                    controller: _controller.cep,
                    keyBoarType: TextInputType.number,
                    mask: '99999-999',
                    onComplete: ()=> _controller.recuperaEndereco()
                  ),
                  _customWidgets.customTextField(
                    label: 'Endereço (automático pelo Cep)',
                    controller: _controller.endereco,
                    enable: false
                  ),
                  _customWidgets.customTextField(
                    label: 'Número (automático pelo Cep)',
                    controller: _controller.numero,
                    enable: false
                  ),
                  GetBuilder<SingUpController>(
                    builder: (_) => Padding( //senha
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: TextFormField(                      
                        obscureText: _controller.obscureText,
                        controller: _controller.senha,
                        validator: (value){
                          return  value.isEmpty || value == '' ? 'este campo nao pode estar vazio' : null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.lock),
                            onPressed: ()=> _controller.changeObscure(),
                          ),
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),        
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    width: Get.width * 0.5,
                    height: Get.height * 0.08,
                    child: RaisedButton(
                      color: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          _userController.saveUser(
                            UserModel(nome: _controller.nome.text,
                              email: _controller.email.text,
                              dataNascimento: _controller.parseDate(),
                              cpf: _controller.cpf.text,
                              cep: _controller.cep.text,
                              endereco: _controller.endereco.text,
                              numero: _controller.numero.text,
                              senha: _controller.senha.text
                            )
                          );
                        }
                      },
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Get.theme.accentColor,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  // RaisedButton(
                  //   onPressed: () => _userController.deletaDataBase(),
                  //   child: Text('deleta db'),
                  // )
                ],
              ),
            ),
          ],
        ),
      ) 
      
    );
  }
}
