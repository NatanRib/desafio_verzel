
import 'package:verzel_teste/app/models/address_model.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../service/api_cep.dart';

class EnderecoRepository {
  
  ApiCep serviceCep;

  EnderecoRepository({@required this.serviceCep});
  AddressModel endereco;
  Future<AddressModel> getAndress(String cep)async{
    await serviceCep.consulta(cep).then((value){
      endereco = AddressModel.fromJson(jsonDecode(value));
    });
    return endereco;
  }
}