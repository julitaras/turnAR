import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Appointment {
  String _id;
  User? _user;
  DateTime _date;
  TimeOfDay _time;
  String _site;
  String _reason;

  Appointment(
      this._id, this._user, this._date, this._time, this._site, this._reason);

  String get id => _id;

  DateTime get date => _date;

  User? get user => _user;

  String get site => _site;

  TimeOfDay get time => _time;

  String get reason => _reason;

  var _weekday = {
    'Monday': 'Lunes',
    'Tuesday': 'Martes',
    'Wednesday': 'Miércoles',
    'Thrusday': 'Jueves',
    'Friday': 'Viernes',
    'Saturday': 'Sábado',
    'Sunday': 'Domingo'
  };

  String get timeString {
    return formatTimeOfDay(_time);
  }

  String get dateTimeString {
    return this.dateString + ', ' + this.timeString;
  }

  String get dateString {
    var weekday = _weekday[DateFormat('EEEE').format(_date)];
    if (weekday == null) {
      weekday = "";
    }
    return weekday + ' ' + DateFormat('dd-MM-yyyy').format(_date);
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}
