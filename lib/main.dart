import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to TurnAr',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'TurnAR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _saveTheDate(context) {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('Info'),
              content: Text('Date saved'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Accept'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  isDefaultAction: false,
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop("Cancel");
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/banner.jpeg'),
                  const ListTile(
                    title: Text('¡Bienvenido a TurnAR!'),
                    subtitle: Text('Plan de Vacunación COVID-19'),
                  )
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 60.0),
              child: Column(
                children: <Widget>[
                  const ListTile(
                    title: Text('Próximo Turno:')
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('25 de Julio, 08:45hs')
                    ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: const Text('VER TURNO'),
                        onPressed: () { _saveTheDate(context); },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _saveTheDate(context);
                },
                child: const SizedBox(
                  width: 600,
                  height: 50,
                  child: Text('\nVer Mis Turnos',textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveTheDate(context);
        },
        tooltip: 'Save the date',
        child: Icon(Icons.calendar_today),
      ),
    );
  }
}
