import 'package:app_turnar/domain/appointment.dart';
import 'package:app_turnar/pages/show_appointment.dart';
import 'package:app_turnar/services/appointment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppointments extends StatefulWidget {
  MyAppointments({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  late User _user;

  void initState() {
    super.initState();
    _user = widget._user;
    _loadAppointments();
  }

  Widget buildBody(BuildContext context, Appointment? appointment) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ShowAppointment(user: _user, appointment: appointment!)));
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  title: Text(
                appointment!.reason,
                style: TextStyle(fontSize: 17),
              )),
              Text(appointment.dateTimeString),
              Text(appointment.site),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Appointment?>>(
        future: _loadAppointments(),
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) =>
                          buildBody(context, snapshot.data![index])))
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("Mis Turnos"),
              ),
              body: Container(
                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    children: children,
                  )));
        });
  }

  Future<List<Appointment?>> _loadAppointments() async {
    return AppointmentService().getAllUserAppointments();
  }
}
