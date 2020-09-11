import 'package:probando_flutter/app/Config/config.dart';

//webservices
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
 Future loginService(String usuario,String password) async {
    try {
      final response = await http
          .post(ROOT+'login/supervisor/',body: {
      "usuario": usuario.trim(),
      "contrasena": password.trim(),
    });
    print(response.body);
      return json.decode(response.body);
      /*if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("ERROR");
        return json.decode(response.body);
      }*/
    } catch (e) {
      print("eee");
      print(e);
      return e;
    }
}