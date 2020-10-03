import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:verzel_teste/app/models/address_model.dart';
import 'package:verzel_teste/app/modules/singup/repository/endereco_repository.dart';

class SingUpController extends GetxController {

final EnderecoRepository repository;
SingUpController({@required this.repository}) : assert(repository != null);

  TextEditingController nome;
  TextEditingController email;
  TextEditingController dataNasciemnto;
  TextEditingController cpf;
  TextEditingController cep;
  TextEditingController endereco;
  TextEditingController numero;
  TextEditingController senha;
  AddressModel _enderecoRecuperado;
  bool obscureText = false;

  @override
  void onInit() {
    nome = TextEditingController();
    email = TextEditingController();
    dataNasciemnto = TextEditingController();
    cpf = TextEditingController();
    cep = TextEditingController();
    endereco = TextEditingController();
    numero = TextEditingController();
    senha = TextEditingController();
    super.onInit();
  }

  changeObscure(){
    obscureText = !obscureText;
    update();
  }

  String validaCpf(String value){
    if (value.isEmpty){
      return null;
    }
    int cpf = int.parse(value.replaceAll('.', '').replaceAll('-', '').substring(0, 9));
    int n1 = cpf ~/ 100000000;
    int n2 = cpf % 100000000 ~/ 10000000;
    int n3 = cpf % 100000000 % 10000000 ~/ 1000000;
    int n4 = cpf % 100000000 % 10000000 % 1000000 ~/ 100000;
    int n5 = cpf % 100000000 % 10000000 % 1000000 % 100000 ~/ 10000;
    int n6 = cpf % 100000000 % 10000000 % 1000000 % 100000 % 10000 ~/ 1000;
    int n7 = cpf % 100000000 % 10000000 % 1000000 % 100000 % 10000 % 1000 ~/ 100;
    int n8 = cpf % 100000000 % 10000000 % 1000000 % 100000 % 10000 % 1000 % 100 ~/ 10;
    int n9 = cpf % 100000000 % 10000000 % 1000000 % 100000 % 10000 % 1000 % 100 % 10;
    var n10 = (11 - (n1*10 + n2*9 + n3*8 + n4*7 + n5*6 + n6*5 + n7*4 + n8*3 + n9*2) % 11);
    n10 > 9 ? n10 = 0 : n10 = n10;
    var n11 = (11 - (n1*11 + n2*10 + n3*9 + n4*8 + n5*7 + n6*6 + n7*5 + n8*4 + n9*3 + n10*2) % 11);
    n11 > 9 ? n11 = 0 : n11 = n11;
    if (n10.toString() == value.substring(12, 13) 
      && n11.toString() == value.substring(13)){
        return null;
    }
    return 'CPF invalido';
  }

  String validaIdade(String value){
    int index = value.lastIndexOf('/');
    String ano = value.substring(index + 1);
    print(ano.toString());
    if (ano != '' && ano != null){
      if (ano.length < 4){
        return 'Ano do nascimento deve conter 4 digitos';
      }
      if (int.parse(value.substring(0,2)) > 31){
        return 'o dia não pode ser maior que 31';
      }
      if (int.parse(value.substring(3,5)) > 12){
        return 'o mês não pode ser maior que 12';
      }
      int idade = DateTime.now().year - int.parse(ano);
      return idade <= 12 ? 'Você deve ter 12 anos ou mais para se cadastrar' : null;
    }
    return 'este campo nao pode estar vazio';
  }

  void recuperaEndereco()async{
    String cepPesquisa = cep.text.replaceAll('-', ''); 
    _enderecoRecuperado = await repository.getAndress(cepPesquisa);
    print(_enderecoRecuperado.estado);
    if (_enderecoRecuperado.estado.isNull){
      endereco.text = 'Cep não existe';
      numero.text = 'Cep não existe';
      update();
    }else{
      endereco.text = '${_enderecoRecuperado.logradouro} ' +
      '${_enderecoRecuperado.cidade}' + 
        ' - ${_enderecoRecuperado.estado} ';
      numero.text = '${_enderecoRecuperado.numero != null ? _enderecoRecuperado.numero != null : ''}';
      update();
    }
  }

  clearTextController(){
    nome.text = '';
    email.text = '';
    dataNasciemnto.text = '';
    cpf.text = '';
    cep.text = '';
    endereco.text = '';
    numero.text = '';
    senha.text = '';
  }

  DateTime parseDate(){
    var date = DateTime.parse(
      '${dataNasciemnto.text.substring(6)}-' +
      '${dataNasciemnto.text.substring(3, 5)}-'
      + '${dataNasciemnto.text.substring(0, 2)}'
    );
    return date;
  }
}