import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_turnar/pages/watchAppointment.dart';
import 'package:app_turnar/pages/myAppointments.dart';
import 'package:app_turnar/pages/saveAppointment.dart';
import 'package:app_turnar/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title, required User user})
      : _user = user,
        super(key: key);

  final String title = 'TurnAr';
  final User _user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

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
                  height: 200,
                  fit:BoxFit.fill),
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
                    children: <Widget>[Text('25 de Julio, 08:45hs')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: const Text('VER TURNO'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WatchAppointment(user: _user)));
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyAppointments()));
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TakeTurn()));
        },
        tooltip: 'Agendar Turno Nuevo',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
