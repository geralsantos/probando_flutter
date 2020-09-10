import 'dart:io';
import 'package:get/route_manager.dart';
import 'package:probando_flutter/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:probando_flutter/login/login.dart';
import 'package:probando_flutter/login/onboardingScreen/onboarding.dart';
import 'package:probando_flutter/login/splash_screen.dart';
import 'package:probando_flutter/pages/Inicio/Inicio.dart';
import 'package:probando_flutter/pages/components/TableCalendar.dart';
import 'package:probando_flutter/utils/dart/sharedPreferences.dart'; 
import 'navigation.dart';
import 'package:probando_flutter/pages/components/ListadoClases.dart';
import 'package:intl/intl.dart'; 
import 'package:intl/date_symbol_data_local.dart';


  sharedPreferences sharedPrefs = new sharedPreferences();

void main() async {

  Intl.defaultLocale = 'es';
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.open();
    
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
  ]).then((_) => initializeDateFormatting().then((_) => runApp(MyApp())) );

  
}  
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
/*
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}*/
class _MyAppState  extends State<MyApp> {
   @override
   void initState() {
     super.initState();
   }
   Future<String> cargarData() async {
     var data = sharedPrefs.read("dataUsuario",null);
     /*if (data!=null) {
      Navigator.pushReplacementNamed(context, '/app');
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => OnboardingScreen()));
    }*/

    return data;
   }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        secondaryHeaderColor: Colors.blueAccent,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
        fontFamily: 'Quicksand'
      ),
      //home: SplashScreen()
      home: FutureBuilder(
        future: cargarData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data!=null) {
            return NavigationHomeScreen();
          } else {
            return OnboardingScreen();
          }
        }
      ),routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginThreePage(),
        '/onBoarding': (BuildContext context) => new OnboardingScreen(),
        '/app': (BuildContext context) =>  new NavigationHomeScreen(),
        '/inicio': (BuildContext context) =>  new Inicio(),
      },
      //home: ColorLoader3()
      //home: OnboardingScreen(),
      //home: TableCalendarC(),
     // home: ListadoClases(),
      //home: NavigationHomeScreen(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
