import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:probando_flutter/app/Models/Clases.dart';
import 'package:probando_flutter/app/Services/Calendario/CalendarioService.dart';
import 'package:probando_flutter/pages/components/ListadoClases.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime today = DateTime.now();
var _selectedDay = today;
dynamic _week = today.weekday;

class TableCalendarC extends StatefulWidget {
  TableCalendarC({Key key}) : super(key: key);
  @override
  _TableCalendarCState createState() => _TableCalendarCState();
}

class _TableCalendarCState extends State<TableCalendarC> {
  CalendarController _controller;
  Map<DateTime, List<Clases>> _events = Map();
  List _selectedEvents;
  List<Clases> clasesList = <Clases>[];
  DateTime dateDesdeFecha;
  DateTime dateHastaFecha;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();

    HashMap<String, DateTime> datesOfWeek = getDaysOfWeek();
    dateDesdeFecha = datesOfWeek["fecha_inicio"];
    dateHastaFecha = datesOfWeek["fecha_fin"];
    _getDataClases(dateDesdeFecha, dateHastaFecha);
    //_selectedEvents = _events[_selectedDay] ?? [];
  }

  HashMap<String, DateTime> getDaysOfWeek() {
    DateTime _today = today, _todayFin = today;
    HashMap map1 = new HashMap<String, DateTime>();
    while (_today.weekday != 1) {
      _today = _today.subtract(new Duration(days: 1));
    }
    while (_todayFin.weekday != 7) {
      _todayFin = _todayFin.add(new Duration(days: 1));
    }
    map1["fecha_inicio"] = _today;
    map1["fecha_fin"] = _todayFin;
    return map1;
  }

  Future<List<Clases>> _getDataClases(
      DateTime fechaIni, DateTime fechaFin) async {
    return await calendarioService(fechaIni, fechaFin).then((value) async {
      _events = {};

      value.forEach((clase) {
        if (clase.fecha != null && clase.fecha != "") {
          if (_events[DateTime.parse(clase.fecha.toString())] == null) {
            _events[DateTime.parse(clase.fecha.toString())] = [];
          }
          _events[DateTime.parse(clase.fecha.toString())].add(clase);
        }
      });
      setState(() {
        clasesList = value;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      height: size.height - 100,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        TableCalendar(
          events: _events,
          calendarController: _controller,
          initialCalendarFormat: CalendarFormat.week,
          calendarStyle: CalendarStyle(
            todayColor: Theme.of(context).secondaryHeaderColor,
            selectedColor: Colors.blue[200],
            todayStyle: TextStyle(color: Colors.white),
            markersColor: Colors.redAccent
          ),
          onDaySelected: (date, events) {
            //print(events);
            setState(() {
              clasesList = events;
            });
            /*setState(() {
              _selectedEvents = events;
            });*/
          },
          onVisibleDaysChanged: (dateF, dateL, format) {
            /*  print(dateF); //datefirst
            print(dateL); //datelast
            print(format); //formato (dia, semana, mes) def:semana*/
            /*setState(() {
              dateDesdeFecha = dateF;
              dateHastaFecha = dateL;
              //_selectedDay = dateF;
            });*/
            _getDataClases(dateF, dateL);
          },
          availableCalendarFormats: {
            CalendarFormat.week: "Semana",
          },
          headerStyle: HeaderStyle(
              formatButtonDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0)),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              formatButtonShowsNext: false),
          startingDayOfWeek: StartingDayOfWeek.monday,
        ),
        Expanded(
            child: Container(
          child: ListadoClases(clasesList),
          /*child: FutureBuilder(
              future: prueba(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                } else {
                  print("dateDesdeFecha");
                  print(dateDesdeFecha);
                  return ListadoClases(dateDesdeFecha,dateHastaFecha) ;
                }
              },
            ),*/
        ))
      ]),
    ));
  }
/*
  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }*/
}
