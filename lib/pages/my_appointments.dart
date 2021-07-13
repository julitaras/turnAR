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
  void initState() {
    super.initState();
    _loadAppointments();
  }

/*
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
              ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: Center(
                      child: Text(
                        list[index]!.reason,
                      ),
                    ));
                  })
            ],
          ),
        ));
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _loadAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              'There was an error :(',
              style: Theme.of(context).textTheme.headline,
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Center(
                    child: Column(children: <Widget>[
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(snapshot.data![index].toString()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ));
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  _loadAppointments() async {
    return AppointmentService().getAllUserAppointments();
  }
}
