import 'package:app_turnar/pages/showAppointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/appointment.dart';

class MyAppointments extends StatelessWidget {

  MyAppointments({Key? key, required User user})
      : _user = user, super(key: key);

  final User _user;

  //TODO deberia mostrar los turnos que trae de la DB
  final Appointment appointment1 = Appointment( date: new DateTime.utc(2021, 7, 23), time: new TimeOfDay(hour: 15, minute: 0), description: "Primera Dosis".toUpperCase(), hospital: 'Hospital de Clínicas');
  final Appointment appointment2 = Appointment( date: new DateTime.utc(2021, 8, 25), time: new TimeOfDay(hour: 15, minute: 0), description: "Segunda Dosis".toUpperCase(), hospital: 'Hospital de Clínicas');
  final Appointment appointment3 = Appointment( date: new DateTime.utc(2021, 9, 28), time: new TimeOfDay(hour: 15, minute: 0), description: "Chequeo".toUpperCase(), hospital: 'Hospital de Clínicas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mis Turnos"),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowAppointment(user: _user, appointment: appointment1))
                  );},
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                          title: Text(
                        appointment1.description,
                        style: TextStyle(fontSize: 17),
                      )),
                      Text(appointment1.dateTimeString),
                      Text(appointment1.hospital),
                    ],
                  ),
                ),
              ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowAppointment(user: _user, appointment: appointment2))
                  );},
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                          title: Text(
                        appointment2.description,
                        style: TextStyle(fontSize: 17),
                      )),
                      Text(appointment2.dateTimeString),
                      Text(appointment2.hospital),
                    ],
                  ),
                ),
              ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowAppointment(user: _user, appointment: appointment3))
                  );},
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                          title: Text(
                        appointment3.description,
                        style: TextStyle(fontSize: 17),
                      )),
                      Text(appointment3.dateTimeString),
                      Text(appointment3.hospital),
                    ],
                  ),
                ),
              ),
              ),
            ],
          ),
        ));
  }
}
