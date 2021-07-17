import 'package:app_turnar/api/calendarClient.dart';
import 'package:app_turnar/domain/appointment.dart';
import 'package:app_turnar/pages/home.dart';
import 'package:app_turnar/pages/set_appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_turnar/services/appointment_service.dart';

class ShowAppointment extends StatefulWidget {
  ShowAppointment(
      {Key? key, required User user, required Appointment appointment})
      : _user = user,
        _appointment = appointment,
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
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(_appointment.dateTimeString),
              subtitle: Text(_appointment.reason + " - " + _appointment.site),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => SetAppointment(
                                isEditingPage: true,
                                user: _user,
                                title: "Editar Turno",
                                appointment: _appointment,
                              )))
                      .then((_) => setState(() {}));
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
                                  AppointmentService().deleteData(_appointment);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Turno Eliminado'),
                                    backgroundColor: Colors.red,
                                  ));
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
            Container(
                margin: EdgeInsets.only(top: 450),
                width: 300,
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
                    onPressed: () => CalendarClient().insert(_appointment.date,
                        (_appointment.date).add(Duration(minutes: 30)))))
          ],
        ),
      ),
    );
  }
}
