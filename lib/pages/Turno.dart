import 'package:flutter/material.dart';

class ReservarTurnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var hospital = [
    'Hospital de Clínicas',
    'Hospital Fernández',
    'Hospital Garrahan',
    'Hospital Rivadavia'
  ];
  String select = '';
  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    select = hospital[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservar Turno")),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
                child: DropdownButton(
                    hint: Text("Elegí tu Sede"),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 32,
                    isExpanded: true,
                    underline: SizedBox(),
                    style: TextStyle(fontSize: 22, color: Colors.black),
                    items: hospital.map((String valueItem) {
                      return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                    value: select,
                    onChanged: (String? newValue) {
                          setState(() {
                            select = newValue!;
                          });
                    },
                )),
            Flexible(
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Elegí Fecha")))
            //Calendar())
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1));

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }
}
