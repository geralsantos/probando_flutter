import 'dart:convert';

import 'package:get/get.dart';
import 'package:probando_flutter/utils/dart/sharedPreferences.dart';

class InicioController extends GetxController{
  String _nombres="";
  String get nombres => _nombres; //para llamar desde la vista
  Map<String,dynamic>  _dataUser = new Map<String,dynamic>() ;
  Map<String,dynamic> get dataUser => _dataUser ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getDataUser();
  }
  void getDataUser() async {
    sharedPreferences sPreferences = new sharedPreferences();
    dynamic data = await sPreferences.read("dataUsuario","");
    data = json.decode(data);
    this._dataUser["nombres"] = data["nombres"];
    this._dataUser["apellidos"] = data["apellidos"];
    update(["datos_usuario"]);
  }
  void getNombre(){
    this._nombres = "presionado";
    update(["_nombres"]);
  }
}