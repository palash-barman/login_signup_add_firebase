import 'package:flutter/material.dart';

bool formValidete(GlobalKey<FormState> globalKey){
  final _form= globalKey.currentState;
  if(_form!.validate()){
    _form.save();
    return true;
  }
  return false;
}