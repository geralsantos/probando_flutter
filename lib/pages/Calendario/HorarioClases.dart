import 'package:probando_flutter/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:probando_flutter/pages/components/TableCalendar.dart';

class HorarioClases extends StatefulWidget {
  const HorarioClases({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HorarioClases> with TickerProviderStateMixin {
  //AnimationController animationController;
  bool multiple = true;

  @override
  void initState() {
   /* animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);*/
    
    super.initState();
  }

  Future<bool> getData() async {
    
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }


  @override
  void dispose() {
    //animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: size.height,
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 22, right: 22),
                                  width: size.width,
                                  decoration:
                                      BoxDecoration(),
                                  child: TableCalendarC(),
                                )
                              ],
                            ),
                          );
                          /*return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              
                              Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                  border: Border.all()
                                ),
                                child:  Text(size.width.toString()),
                              ),
                            ],
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: multiple ? 2 : 1,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.5,
                            ),
                          );*/
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Horario de clases',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
