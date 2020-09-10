

import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:probando_flutter/utils/dart/FormBackup.dart';

class CheckInternet{
  FormBackup backup = new FormBackup();

  Future<bool> accessInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      dynamic activeInternet = await backup.read("activeInternet", "true");
      if (activeInternet == "false") return false;
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network, make sure there is actually a net connection.
        if (await DataConnectionChecker().hasConnection) {
         /* try {
            var docs = await helper.getDocuments();
            if (docs == null) {
              return false;
            }
          } on SocketException catch (_) {
            return false;
          } catch (ex) {
            return false;
          }*/
          // Mobile data detected & internet connection confirmed.
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          return false;
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a WIFI network, make sure there is actually a net connection.
        if (await DataConnectionChecker().hasConnection) {
          /*try {
            var docs = await helper.getDocuments();
            if (docs == null) {
              return false;
            }
          } on SocketException catch (_) {
            return false;
          } catch (ex) {
            return false;
          }*/
          // Wifi detected & internet connection confirmed.
          return true;
        } else {
          // Wifi detected but no internet connection found.
          return false;
        }
      } else {
        // Neither mobile data or WIFI detected, not internet connection found.
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}