import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:probando_flutter/app/Services/Login/LoginService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:probando_flutter/utils/flutter/Utils.dart';
import 'package:probando_flutter/utils/dart/sharedPreferences.dart';
import 'package:probando_flutter/utils/dart/checkInternet.dart';
import 'package:probando_flutter/utils/dart/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

sharedPreferences sharedPrefs = new sharedPreferences();
CheckInternet checkInternet = new CheckInternet();
UtilToast toast = new UtilToast();

class LoginThreePage extends StatefulWidget {
  LoginThreePage({Key key}) : super(key: key);
  @override
  _LoginThreePageState createState() => _LoginThreePageState();
}

class _LoginThreePageState extends State<LoginThreePage> {
  Utils utils = new Utils();
  BuildContext context;
  bool _showLoader = false, _showDialogResponse = false;
  bool passwordObscure = true;
  String usuario = "", contrasena = "";
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future initData() async {
    await sharedPrefs.open();
  }

  void _loginService(BuildContext _context) async {
    //String title,String description,String btnOk

    utils.dialogLoadingData(
        Icons.check_circle, Colors.green, "Cargando...", _context);
    loginService(usuario, contrasena).then((onValue) {
      utils.cerrarDialogGlobal(_context);
      if (onValue["status"] != false) {
        var data = onValue["dataUsuario"];
        sharedPrefs.save("dataUsuario", json.encode(data));
        successLogin(_context);
        return;
      }
      utils.showDialogResponse(_context, onValue["mensaje"].toString(), null,
          "Cerrar", AlertType.error);
    }).catchError((e) {
      print("geraaaa");
      toast.showToast("No se estableció la conexión.", _context);
    });
  }

  void successLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/app');
    /*Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => NavigationHomeScreen()));*/
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height / 0.5,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.deepPurple, Colors.deepPurple.shade200],
                    [Colors.indigo.shade200, Colors.purple.shade200],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 30.0),
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          )),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: Container(
                        width: 70,
                        child: Image.asset('assets/images/lgsoftware.png'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            usuario = val;
                          });
                        },
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black26,
                            ),
                            suffixIcon: Icon(
                              (usuario.isEmpty
                                  ? Icons.error_outline
                                  : Icons.check_circle),
                              color:
                                  usuario.isEmpty ? Colors.red : Colors.green,
                            ),
                            hintText: "Usuario",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            contrasena = val;
                          });
                        },
                        obscureText: passwordObscure,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black26,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => {
                                if (!contrasena.isEmpty)
                                  {
                                    setState(() {
                                      passwordObscure = !passwordObscure;
                                    })
                                  }
                              },
                              icon: Icon(contrasena.isEmpty
                                  ? Icons.error_outline
                                  : (passwordObscure ? Icons.visibility_off : Icons.visibility)),
                              color: contrasena.isEmpty
                                  ? Colors.red
                                  : Colors.black45,
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 30.0, right: 30.0, left: 30.0, bottom: 20),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        color: Colors.pink,
                        onPressed: () async {
                          if (!(await checkInternet.accessInternet())) {
                            toast.showToast(
                                "No hay conexión a internet.", context);
                          } else {
                            _loginService(context);
                          }
                        },
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Ingresar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
