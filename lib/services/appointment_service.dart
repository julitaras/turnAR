import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class AppointmentService {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createData() {
    var uuid = Uuid();
    //child es el nombre del objeto json que lo contiene:

    final appointmentsRef = databaseReference.child("appointments");
    appointmentsRef.child("appointments").set({
      'id': uuid.v1(),
      'user': 'Deepak Nishad',
      'timestamp': 'Team Lead',
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
