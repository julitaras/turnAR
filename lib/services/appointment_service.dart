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
      'user': _appointment.user.uid,
      'timestamp': 'test',
      //TODO: Unhandled Exception: Invalid argument: Instance of 'DateTime'
      'site': _appointment.site
    });

    final usersRef = databaseReference.child("users");
    usersRef.child(_appointment.user.uid).set({
      'last_appointment': _uuid,
    });
    getAllAppointments();
  }

  Future<void> getNextAppointments() async {
    //Ver proximo turno (desde la fecha actual) si esta despues de la
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    Map? _appointments = await getAllAppointments();

    databaseReference.child('users').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic>.from(snapshot.value).forEach((key, values) {
        if (_appointments!.keys.firstWhere(
            (element) => _appointments[element] == values['last_appointment'],
            orElse: () => false)) {
          print(snapshot.value);
          return snapshot.value;
        }
      });
    });
  }

  Future<Map<dynamic, dynamic>?> getAllAppointments() async {
    // Ver todos los turnos de un usuario
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
