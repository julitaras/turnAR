import 'package:app_turnar/api/calendarClient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetAppointment extends StatefulWidget {
  SetAppointment({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _SetAppointmentState createState() => _SetAppointmentState();
}

class _SetAppointmentState extends State<SetAppointment> {
  late User _user;

  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  List<String> sites = [
    'Hospital de Clínicas',
    'Hospital Fernández',
    'Hospital Garrahan',
    'Hospital Rivadavia'
  ];
  String selectedSite = 'Hospital Rivadavia';
  String emailValue = '';
  CalendarClient calendarClient = CalendarClient();

  @override
  void initState() {
    _user = widget._user;

    super.initState();
    emailController.text = _user.email!;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          title: Text("Reservar Turno"),
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
            child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                controller: emailController,
                                onSaved: (value) {
                                  emailValue = value!;
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
                                }))
                      ]),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Elegí Tu Sede:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ])),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: DropdownButton(
                          value: selectedSite,
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
                              selectedSite = newValue!;
                            });
                          },
                          items: sites.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child:
                                  Text(value, style: TextStyle(fontSize: 18)),
                            );
                          }).toList(),
                        ))
                      ]),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Elegí la Fecha:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Card(
                              shadowColor: Colors.lightGreen,
                              child: ListTile(
                                title: Text(
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green)),
                                trailing: Icon(Icons.arrow_drop_down),
                                onTap: _pickDate,
                              ),
                            ))
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Elegí la Hora:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Card(
                              shadowColor: Colors.lightGreen,
                              child: ListTile(
                                title: Text(
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green)),
                                trailing: Icon(Icons.arrow_drop_down),
                                onTap: _pickDate,
                              ),
                            ))
                          ])),
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      width: double.infinity,
                      child: ElevatedButton(
                          child: Text("Guardar",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          onPressed: () => {
                                /* TODO debe guardar en la base el turno
                              */
                              })),
                  // TODO el boton de Calendar debe ir en VerTurno
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: Text("Agregar a Google Calendar",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () => calendarClient.insert(pickedDate,
                              pickedDate.add(Duration(minutes: 30)))))
                ]))));
  }

  _pickDate() async {
    final date = await showDatePicker(
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

  String _sayTime() {
    String _hour = "${pickedDate.hour}";
    String _minute = "${pickedDate.minute}";
    if (pickedDate.hour < 10) {
      _hour = "0" + _hour;
    }
    if (pickedDate.minute < 10) {
      _minute = "0" + _minute;
    }
    return _hour + ":" + _minute;
  }

  _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );

    if (time != null) {
      setState(() {
        Duration t = Duration(hours: time.hour, minutes: time.minute);
        pickedDate = pickedDate.add(t);
      });
    }
  }
}
