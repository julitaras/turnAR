import 'package:app_turnar/domain/appointment.dart';
import 'package:app_turnar/pages/show_appointment.dart';
import 'package:app_turnar/services/appointment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppointments extends StatelessWidget {
  MyAppointments({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  //TODO deberia mostrar los turnos que trae de la DB
  final Appointment appointment1 = Appointment(
      null,
      new DateTime.utc(2021, 7, 23),
      new TimeOfDay(hour: 15, minute: 0),
      "Primera Dosis".toUpperCase(),
      'Hospital de Clínicas');
  final Appointment appointment2 = Appointment(
      null,
      new DateTime.utc(2021, 8, 25),
      new TimeOfDay(hour: 15, minute: 0),
      "Segunda Dosis".toUpperCase(),
      'Hospital de Clínicas');
  final Appointment appointment3 = Appointment(
      null,
      new DateTime.utc(2021, 9, 28),
      new TimeOfDay(hour: 15, minute: 0),
      "Chequeo".toUpperCase(),
      'Hospital de Clínicas');

  //TODO deberia mostrar los turnos que trae de la DB
/*  showpics() {
    return FutureBuilder(
        future: _loadAppointments(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(
                fontFamily: "Montesserat",
                fontWeight: FontWeight.w700,
                fontSize: 40.0,
                fontStyle: FontStyle.italic,
              ),
            ));
          }
        });
  }*/

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
                        builder: (context) => ShowAppointment(
                            user: _user, appointment: appointment1)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                            title: Text(
                          appointment1.reason,
                          style: TextStyle(fontSize: 17),
                        )),
                        Text(appointment1.dateTimeString),
                        Text(appointment1.site),
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
                        builder: (context) => ShowAppointment(
                            user: _user, appointment: appointment2)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                            title: Text(
                          appointment2.reason,
                          style: TextStyle(fontSize: 17),
                        )),
                        Text(appointment2.dateTimeString),
                        Text(appointment2.site),
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
                        builder: (context) => ShowAppointment(
                            user: _user, appointment: appointment3)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                            title: Text(
                          appointment3.reason,
                          style: TextStyle(fontSize: 17),
                        )),
                        Text(appointment3.dateTimeString),
                        Text(appointment3.site),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _loadAppointments() async {
    return AppointmentService().getAllUserAppointments();
  }
}
