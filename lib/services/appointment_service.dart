import 'dart:async';

import 'package:app_turnar/domain/appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class AppointmentService {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createData(Appointment _appointment) {
    var uuid = Uuid();

    final appointmentsRef = databaseReference.child("appointments");
    String _uuid = uuid.v1();

    appointmentsRef.child(_uuid).set({
      'user': _appointment.user!.uid,
      'date': _appointment.date,
      'time': _appointment.time,
      'site': _appointment.site,
      'reason': _appointment.reason
    });

    databaseReference.child("users").child(_appointment.user!.uid);
    getAllUserAppointments();
  }

  Future<Map<dynamic, dynamic>?> getAllUserAppointments() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    databaseReference
        .child("appointments")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key, values) {
        if (values['user'] == user!.uid) {
          return snapshot.value;
        }
      });
    });
  }

/*
  void updateData() {
    final appointmentsRef = databaseReference.child("appointments");
    appointmentsRef.child('appointments').update({'timestamp': 'CEO'});
  }*/

}
