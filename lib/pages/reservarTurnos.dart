import 'package:flutter/material.dart';


class ReservarTurnos extends StatelessWidget {
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Reservar Turno")),
        body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(child: Text("Elegí sede:", style: TextStyle(fontSize: 18))),
                  Flexible(child: DropDownValue()),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(child: Text("Elegí Turno:", style: TextStyle(fontSize: 18))),
                    Flexible(child: Calendar())
                  ]
                )
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Flexible(child: Text("Ingrese su email:", style: TextStyle(fontSize: 18))),
                  Flexible(child: EmailBoxValue())
                  ],
                )
              )
            ]
          ),

        ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class DropDownValue extends StatefulWidget {

  @override
  _DropDownValueState createState() => _DropDownValueState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownValueState extends State<DropDownValue> {
  String dropdownValue = 'Hospital Garrahan';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Selecciona tu Sede'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 16,
      elevation: 16,
      style: const TextStyle(color: Colors.green),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Hospital de Clínicas', 'Hospital Fernández', 'Hospital Garrahan', 'Hospital Rivadavia']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}

class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${pickedDate.day}/${pickedDate.month}/${pickedDate.year}/${pickedDate.hour}"),
      trailing: Icon(Icons.keyboard_arrow_down),
      onTap: _pickDate,
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year-1),
        lastDate: DateTime(DateTime.now().year+1)
    );



    if(date != null){
      setState(() {
        pickedDate = date;
      });
    }
  }
}




// Create a Form widget.
class EmailBoxValue extends StatefulWidget {
  @override
  _EmailBoxValueState createState() {
    return _EmailBoxValueState();
  }
}


class _EmailBoxValueState extends State<EmailBoxValue> {

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                //if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                //}
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}