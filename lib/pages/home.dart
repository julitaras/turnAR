import 'package:app_turnar/domain/appointment.dart';
import 'package:app_turnar/pages/my_appointments.dart';
import 'package:app_turnar/pages/set_appointment.dart';
import 'package:app_turnar/pages/show_appointment.dart';
import 'package:app_turnar/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title, required User user})
      : _user = user,
        super(key: key);

  final String title = 'TurnAr';
  final User _user;

  final String noticias = "https://vacunatepba.gba.gob.ar/";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;
  late String noticias;

  @override
  void initState() {
    _user = widget._user;
    noticias = widget.noticias;

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
                  const ListTile(title: Text('Novedades')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ 
                      Image.asset('assets/images/novedades.jpg',
                      height: 100, fit: BoxFit.fill
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Ver Novedades'),
                        onPressed: () {
                          _launchURL();
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
                  isEditingPage: false, user: _user, title: "Reservar Turno")));
        },
        tooltip: 'Agendar Turno Nuevo',
        child: Icon(Icons.calendar_today),
      ),
    );
  }

  void _launchURL() async =>
    await canLaunch(this.noticias) ? await launch(this.noticias) : throw 'Could not launch $this.noticias';
}
