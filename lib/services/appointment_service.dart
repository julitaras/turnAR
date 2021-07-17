import 'dart:async';

import 'package:app_turnar/domain/appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppointmentService {
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<void> createData(Appointment _appointment) async {
    var uuid = Uuid();

    final appointmentsRef = databaseReference.child("appointments");
    String _uuid = uuid.v1();

    appointmentsRef.child(_uuid).set({
      'user': _appointment.user!.uid,
      'date': _appointment.date.toString(),
      'time': _appointment.formatTimeOfDay(_appointment.time),
      'site': _appointment.site,
      'reason': _appointment.reason
    });

    databaseReference.child("users").child(_appointment.user!.uid);
  }

  TimeOfDay timeConvert(String normTime) {
    int hour;
    int minute;
    String ampm = normTime.substring(normTime.length - 2);
    String result = normTime.substring(0, normTime.indexOf(' '));
    if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
      hour = int.parse(result.split(':')[0]);
      if (hour == 12) hour = 0;
      minute = int.parse(result.split(":")[1]);
    } else {
      hour = int.parse(result.split(':')[0]) - 12;
      if (hour <= 0) {
        hour = 24 + hour;
      }
      minute = int.parse(result.split(":")[1]);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  Appointment? convertToAppointment(dynamic appointment) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (appointment['user'] == user!.uid) {
      DateTime date = DateTime.parse(appointment['date']);
      TimeOfDay time = timeConvert(appointment['time']);
      return Appointment(
          user, date, time, appointment['site'], appointment['reason']);
    }
  }

  Future<List<Appointment?>> getAllUserAppointments() async {
    List<Appointment?> list = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    databaseReference
        .child("appointments")
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      Map<dynamic, dynamic>.from(snapshot.value)
          .forEach((appointmentID, appointment) {
        if (appointment['user'] == user!.uid) {
          Appointment? app = convertToAppointment(appointment);
          list.add(app);
        }
      });
    });
    return list;
  }

/*
  void updateData() {
    final appointmentsRef = databaseReference.child("appointments");
    appointmentsRef.child('appointments').update({'timestamp': 'CEO'});
  }*/

}
