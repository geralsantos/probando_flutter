import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

class DropDownFormField extends StatefulWidget {
  /*
  {
  'items_': items_,
  'label': 'SELECCIONE UN PROYECTO',
  'icon': Icons.collections_bookmark,
  'messagesErrors':{'required':'Debe seleccionar un proyecto'},
  'validate': "required"
}
   */
  Map<String, dynamic> options;
  void Function(dynamic) callBackResponse;
  DropDownFormField(Map<String, dynamic> options,
      [void Function(dynamic) callBackResponse]) {
    this.options = options;
    this.callBackResponse = callBackResponse;
  }
  @override
  _DropDownFormFieldState createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  // A function that converts a response body into a List<Proyecto>.
  int _selected = 0;
  List<DropdownMenuItem<int>> itemsList = [];

  void cargarRegistros() {
    itemsList = [];
    int i = 1;
    if (widget.options["items_"] != null &&
        widget.options["items_"].length > 0) {
      itemsList.add(new DropdownMenuItem(
        child: new Container(
          width: MediaQuery.of(context).size.width / 1.8,
          child: AutoSizeText(
            widget.options["label"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        value: 0,
      ));
      for (var item in widget.options["items_"]) {
        itemsList.add(new DropdownMenuItem(
          child: new Text(
            item["nombre"],
            overflow: TextOverflow.ellipsis,
          ),
          value: i,
        ));
        i++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    cargarRegistros();
    return Container(
        height: 80,
            padding: const EdgeInsets.only(bottom: 5.0),

        child: DropdownButtonFormField(
          itemHeight: 50,
          
          value: _selected,
          hint: FittedBox(
              fit: BoxFit.fitWidth,
              child: new Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: new Text(
                  widget.options["label"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          decoration: InputDecoration(

              isDense: true,
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                widget.options["icon"],
                size: 24,
              ),
              helperText: ''),
          items: itemsList,
          onChanged: (value) {
            setState(() {
              _selected = value;
              if (widget.callBackResponse != null) {
                widget.callBackResponse(value - 1);
              }
            });
          },
          validator: (val) {
            var itemvalue;
            if (widget.options["validate"] == null &&
                widget.options["items_"] == null) {
              return null;
            }
            for (var item in widget.options["validate"].split("|")) {
              itemvalue =
                  item.split(":").length > 1 ? item.split(":")[1] : null;
              item = item.split(":")[0];
              switch (item) {
                case 'required':
                  if (val == 0) {
                    return widget.options["messagesErrors"][item];
                  }
                  break;
                case 'digits':
                  int digitos = int.parse(itemvalue);
                  if (val.length != digitos) {
                    return widget.options["messagesErrors"][item];
                  }
                  break;
                default:
              }
            }
            return null;
          },
        ));
  }
}
