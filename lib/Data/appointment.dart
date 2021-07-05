import 'package:flutter/src/material/time.dart';
import 'package:intl/intl.dart';



class Appointment {
  DateTime _date;
  TimeOfDay _time;
  String _description;
  String _hospital;

  var _weekday = {'Monday': 'Lunes', 'Tuesday': 'Martes', 'Wednesday': 'Miércoles', 'Thrusday': 'Jueves', 'Friday' : 'Viernes', 'Saturday' : 'Sábado', 'Sunday': 'Domingo'};

  Appointment({required date, required time, required description, required hospital}):
  this._date = date,
  this._time = time,
  this._description = description,
  this._hospital = hospital;

// GETTERS

  DateTime get date {
    return _date;
  }
  TimeOfDay get time {
    return _time;
  }

  String get dateString {
    var weekday =  _weekday[DateFormat('EEEE').format(_date)];
    if (weekday == null){
      weekday = "";
    }
    return weekday + ' ' + DateFormat('dd-MM-yyyy').format(_date);
  }
  String get timeString {
    return formatTimeOfDay(_time);
  }
  String get description {
    return this._description;
  }
  String get hospital {
    return this._hospital;
  }

  String get dateTimeString {
    return this.dateString + ', ' + this.timeString;
  }
  
// SETTERS
  void set date(DateTime date) {
    _date = date;
  }
  void set time(TimeOfDay time) {
    _time = time;
  }
  void set description(String description) {
    _description = description;
  }
  void set hospital(String hospital) {
      _hospital = hospital;
    }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
}
}
