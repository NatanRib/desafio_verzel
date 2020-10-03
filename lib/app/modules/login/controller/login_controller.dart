import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:verzel_teste/app/universal_custom_widgets/uni_custom_widgets.dart';

class LoginController extends GetxController {

final uniCustomWidgets = Get.put(UniCustomWidgets());

  TextEditingController nome;
  TextEditingController senha;
  final _logando = false.obs;
  get logando => _logando.value;
  set logando(bool log) => _logando.value = log;
  final _obscureText = true.obs;
  get obscureText => _obscureText.value;
  set obscureText(bool log) => _obscureText.value = log;


  @override
  void onInit() {
    nome = TextEditingController();
    senha = TextEditingController();
    super.onInit();
  }
}