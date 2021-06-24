import 'package:app_turnar/pages/Login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_turnar/pages/watchTurn.dart';
import 'package:app_turnar/pages/myTurns.dart';
import 'package:app_turnar/pages/saveTurn.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title}) : super(key: key);

  final String title = 'TurnAr';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  void _saveTheDate(context) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('Info'),
              content: Text('Date saved'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Accept'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  isDefaultAction: false,
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Cancel");
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                              builder: (context) => ReservarTurnos()));
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
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveTheDate(context);
        },
        tooltip: 'Agendar Turno Nuevo',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
