import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:probando_flutter/app/Models/Clases.dart';
import 'package:probando_flutter/app/Services/Calendario/CalendarioService.dart';

final formatoFecha = new DateFormat('EEEE d');

class ListadoClases extends StatefulWidget {
  List<Clases> clasesList;

  ListadoClases(this.clasesList, {Key key})
      : super(key: key);

  @override
  LListadoClasesState createState() =>
      LListadoClasesState(this.clasesList);
}

class LListadoClasesState extends State<ListadoClases>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Clases> clasesList;

  LListadoClasesState(this.clasesList);

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  Future<List<Clases>> _getDataClases() async {
    if (widget.clasesList!=null) {
      animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
      return widget.clasesList;
    }
    return null;
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: FutureBuilder<List<Clases>>(
          future: _getDataClases(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Clases>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Container(
                padding: const EdgeInsets.all(8),
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                      children: List<Widget>.generate(
                    snapshot.data.length,
                    (int index) {
                      final int count = snapshot.data.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        
                        child: ClasesView(
                          callback: () {},
                          clases: snapshot.data[index],
                          animation: animation,
                          animationController: animationController,
                        ),
                      );
                    },
                  )),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ClasesView extends StatelessWidget {
  const ClasesView(
      {Key key,
      this.clases,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Clases clases;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 5),
                      blurRadius: 5.0)
                ],
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
              height: 150,
              child: Material(
                  borderRadius: BorderRadius.circular(12.0),
                  color : Colors.white,
                  child: Container(
                    
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    print("wwwww");
                                  },
                                  child: Container(
                                    
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                              top: 16, left: 16, right: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                clases.nombre,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.27,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      ' Hora de inicio: ${clases.hora_inicio}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 17,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),
                                                    Text(
                                                      ' Hora de fin: ${clases.hora_fin}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 17,
                                                        letterSpacing: 0.27,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                
                                                
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.date_range,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),
                                                   Container(
                                                     width: 150,
                                                     child:  Text(
                                                        ' ${formatoFecha.format(DateTime.parse(clases.fecha)).toUpperCase()}',
                                                        style: TextStyle(
                                                        fontSize: 17,
                                                        letterSpacing: 0.27,
                                                      ),
                                                      ),
                                                   )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 48,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
