import 'package:app_turnar/pages/home.dart';
import 'package:app_turnar/pages/setAppointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchAppointment extends StatefulWidget {
  WatchAppointment({Key? key, required User user})
      : _user = user,
        super(key: key);

  final String title = 'TurnAr';
  final User _user;

  @override
  _WatchAppointmentState createState() => _WatchAppointmentState();
}

class _WatchAppointmentState extends State<WatchAppointment> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver Turno"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const ListTile(
              title: Text('25 de Julio, 08.45hs'),
              subtitle: Text('PRIMERA DOSIS'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SetAppointment(user: _user, titulo: "Editar Turno")));
                  // TODO: se tendrían que mandar los datos del turno y cambiar el título general de la view
                },
                child: const Text('Editar'),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                            title: Text('Eliminar Turno'),
                            content: Text(
                                '¿Está seguro/a de que desea eliminar su turno?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text('Aceptar'),
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("Discard");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePage(user: _user)));
                                  // TODO: debe eliminar el turno
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('Cancel'),
                                isDefaultAction: false,
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("Cancel");
                                },
                              ),
                            ],
                          ));
                },
                child: const Text('Eliminar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
