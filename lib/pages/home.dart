import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_turnar/pages/watchTurn.dart';
import 'package:app_turnar/pages/myTurns.dart';
import 'package:app_turnar/pages/saveTurn.dart';
import 'package:app_turnar/pages/user.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title}) : super(key: key);

  final String title = 'TurnAr';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget _upperContainer() {
      return Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UserProfile()));
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
                  Image.asset('assets/images/banner.jpeg'),
                  const ListTile(
                    title: Text('¡Bienvenido a TurnAR!'),
                    subtitle: Text('Plan de Vacunación COVID-19'),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 60.0),
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
                              builder: (context) => VerTurno()));
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
                      .push(MaterialPageRoute(builder: (context) => MyTurns()));
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
