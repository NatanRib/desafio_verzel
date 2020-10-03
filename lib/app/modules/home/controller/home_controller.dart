import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {

  TextEditingController nome;
  TextEditingController entrega;
  TextEditingController conclusao;

  @override
  void onInit() {
    nome = TextEditingController();
    entrega = TextEditingController();
    conclusao = TextEditingController();
    super.onInit();
  }

  crearTextControllers(){
    nome.text = '';
    entrega.text = '';
    conclusao.text = '';
    update();
  }

  DateTime parseDate(String data){

    if (data == '' || data == null){
      return null;
    }

    var date = DateTime.parse(
      '${data.substring(6, 10)}-' +
      '${data.substring(3, 5)}-' +
      '${data.substring(0, 2)} ' +
      '${data.substring(11, 13)}:' +
      '${data.substring(14)}:' +
      '00'
    );
    return date;
  }
}