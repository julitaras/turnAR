import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTurns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mis Turnos"),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const ListTile(
                          title: Text(
                        'PRIMERA DOSIS',
                        style: TextStyle(fontSize: 17),
                      )),
                      Text("25 de Julio, 08.45hs\n"),
                      Text("SEDE: Hospital n 47"),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const ListTile(
                          title: Text(
                        'SEGUNDA DOSIS',
                        style: TextStyle(fontSize: 17),
                      )),
                      Text("25 de Agosto, 08.00hs\n"),
                      Text("SEDE: Hospital n 47"),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const ListTile(
                          title: Text(
                        'CHEQUEO',
                        style: TextStyle(fontSize: 17),
                      )),
                      Text("25 de Noviembre, 10.30hs\n"),
                      Text("SEDE: Hospital n 33"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
