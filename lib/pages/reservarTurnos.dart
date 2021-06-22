import 'package:flutter/material.dart';
import '../api/calendarClient.dart';

class ReservarTurnos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Turno();
  }
}

class Turno extends StatefulWidget {
  @override
  _TurnoState createState() => _TurnoState();
}

class _TurnoState extends State<Turno> {
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  CalendarClient calendarClient = CalendarClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservar Turno")),
      body: SingleChildScrollView(
        child: Container(
          //alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Expanded(child: EmailBoxValue())],
              ),
              Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text("Elegí Tu Sede:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        SingleChildScrollView( child: Expanded(child: DropDownValue()), scrollDirection: Axis.horizontal,
                        )
                      ])),
              Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text("Elegí Tu Fecha:",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                        Expanded(child: DatePicker())
                      ])),
              Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Expanded(
                      //     child: Text("Ingresa Tu Email:",
                      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text("Elegí Tu Hora:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      Expanded(child: TimePicker())
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 90.0),
                child: ElevatedButton(
                  child: Text(
                    "Agregar a Google Calendar",
                  ),
                  onPressed: () {
                    //log('add event pressed');
                    calendarClient.insert(
                      pickedDate,
                      pickedTime
                    );
                  }),
              )
            ]
            ),)
          ),
        ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class DropDownValue extends StatefulWidget {
  @override
  _DropDownValueState createState() => _DropDownValueState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownValueState extends State<DropDownValue> {
  String dropdownValue = 'Hospital Garrahan';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Selecciona tu Sede'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 16,
      elevation: 16,
      style: const TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'Hospital de Clínicas',
        'Hospital Fernández',
        'Hospital Garrahan',
        'Hospital Rivadavia'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.lightGreen,
      child: ListTile(
        //leading: Icon(Icons.access_alarm),
        title: Text("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green)),
        //subtitle: Text(_sayTime()),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: _pickDate,
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

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay pickedTime = TimeOfDay.now();

  String _sayTime() {
    String _hour = "${pickedTime.hour}";
    String _minute = "${pickedTime.minute}";
    if (pickedTime.hour < 10) {
      _hour = "0" + _hour;
    }
    if (pickedTime.minute < 10) {
      _minute = "0" + _minute;
    }
    return _hour + ":" + _minute;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.lightGreen,
      child: ListTile(
        //leading: Icon(Icons.access_alarm),
        title: Text(_sayTime(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.green)),
        //subtitle: Text(_sayTime()),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: _pickTime,
      ),
    );
  }

  _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );

    if (time != null) {
      setState(() {
        pickedTime = time;
      });
    }
  }
}

// Create a Form widget.
class EmailBoxValue extends StatefulWidget {
  @override
  _EmailBoxValueState createState() => _EmailBoxValueState();
}

class _EmailBoxValueState extends State<EmailBoxValue> {
  String? emailValue = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.title;
    // Build a Form widget using the _formKey created above.
    return TextFormField(
        onSaved: (value) {
          emailValue = value;
        },
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: textStyle,
          hintText: 'Ingrese su Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(Icons.mail),
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
        validator: (value) {
          if (value == null) {
            return "Falta completar el Email";
          }
        });
  }
}

// Padding(
//   padding: const EdgeInsets.symmetric(vertical: 16.0),
//   child: ElevatedButton(
//     onPressed: () {
//       // Validate returns true if the form is valid, or false otherwise.
//       //if (_formKey.currentState!.validate()) {
//       // If the form is valid, display a snackbar. In the real world,
//       // you'd often call a server or save the information in a database.
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Processing Data')));
//       //}
//     },
//     child: Text('Submit'),
//   ),
// ),
