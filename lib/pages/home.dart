import 'package:app_turnar/pages/my_appointments.dart';
import 'package:app_turnar/pages/set_appointment.dart';
import 'package:app_turnar/pages/show_appointment.dart';
import 'package:app_turnar/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/appointment.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title, required User user})
      : _user = user,
        super(key: key);

  final String title = 'TurnAr';
  final User _user;
  //TODO deberia mostrar el turno más cercano de los que trae de la DB
  final Appointment closestAppointment = Appointment( date: new DateTime.utc(2021, 7, 23), time: new TimeOfDay(hour: 15, minute: 0), description: "Primera Dosis".toUpperCase(), hospital: 'Hospital de Clínicas');

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;
  late Appointment closestAppointment;

  @override
  void initState() {
    _user = widget._user;
    closestAppointment = widget.closestAppointment;

  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _upperContainer() {
      return Align(
        alignment: Alignment.topRight,
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        child: Image.network(
                          _user.photoURL!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UserProfile(user: _user)));
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            _upperContainer(),
            Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/vaccinated.png',
                      height: 200, fit: BoxFit.fill),
                  const ListTile(
                    title: Text('¡Bienvenido a TurnAR!'),
                    subtitle: Text('Plan de Vacunación COVID-19'),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  const ListTile(title: Text('Próximo Turno:')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(closestAppointment.dateTimeString)],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: const Text('VER TURNO'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowAppointment(user: _user, appointment: closestAppointment))).then((_) => setState(() {}));
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyAppointments(user: _user)));
                },
                child: const SizedBox(
                  width: 600,
                  height: 50,
                  child: Text(
                    '\nVer Mis Turnos',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SetAppointment(
                    user: _user,
                    titulo: "Reservar Turno"
                  )));
        },
        tooltip: 'Agendar Turno Nuevo',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
