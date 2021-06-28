import 'package:firebase_auth/firebase_auth.dart';

class Appointment {
  User _user;
  DateTime _timestamp;
  String _site;

  Appointment(this._user, this._timestamp, this._site);

  User get user => _user;

  DateTime get timestamp => _timestamp;

  String get site => _site;
}
