import 'package:app_turnar/Data/appointment.dart';
import 'package:app_turnar/pages/home.dart';
import 'package:app_turnar/pages/setAppointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAppointment extends StatefulWidget {
  ShowAppointment({Key? key, required User user, required Appointment appointment})
      : _user = user, _appointment = appointment,
        super(key: key);

  final String title = 'TurnAr';
  final User _user;
  final Appointment _appointment;

  @override
  _ShowAppointmentState createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {
  late User _user;
  late Appointment _appointment;

  @override
  void initState() {
    _user = widget._user;
    _appointment = widget._appointment;

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
            ListTile(
              title: Text( _appointment.dateTimeString),
              subtitle: Text('PRIMERA DOSIS'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SetAppointment(user: _user, titulo: "Editar Turno", appointment: _appointment,))).then((_) => setState(() {}));
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
