import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class AppointmentService {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createData(User _user, DateTime _pickedDate) {
    var uuid = Uuid();

    final appointmentsRef = databaseReference.child("appointments");
    appointmentsRef.child(uuid.v1()).set({
      'user': _user.email,
      'timestamp': 'test', //TODO: Unhandled Exception: Invalid argument: Instance of 'DateTime'
      'headquarters': 'River'
    });
  }

/*  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    final appointmentsRef = databaseReference.child("appointments");
    appointmentsRef.child('appointments').update({'timestamp': 'CEO'});
  }*/

}
