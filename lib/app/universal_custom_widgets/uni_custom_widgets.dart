import 'dart:ffi';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UniCustomWidgets{

  snackbar(String title, String message, bool success, int durationInSec){
    Get.snackbar(
      title,
      message,
      duration: durationInSec != null ?
       Duration(seconds: durationInSec) :
        Duration(seconds: 3) ,
      backgroundColor: success ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }

  Widget customTextField(
      {String hint,
      String label,
      bool obrigatorio,
      TextEditingController controller,
      Function validator,
      String mask,
      Function onComplete,
      TextInputType keyBoarType,
      bool enable}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              //filled: true,
              //fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),        
            onEditingComplete: onComplete,
            inputFormatters: mask != null ? [TextInputMask(mask: mask)] : [],
            keyboardType: keyBoarType,
            enabled: enable,
          ),
        ),
        SizedBox(height: 12)
      ],
    ); 
  }
}