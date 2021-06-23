import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './reservarTurnos.dart';
import '../main.dart';

class VerTurno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ver Turno"),),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const ListTile(
              title: Text('25 de Julio, 08.45hs'),
              subtitle: Text('PRIMERA DOSIS'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TakeTurn()));
                  // TODO: se tendrían que mandar los datos del turno y cambiar el título general de la view
                },
                child: const Text('Editar'),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[900],

              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text('Eliminar Turno'),
                      content: Text('¿Está seguro/a de que desea eliminar su turno?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Aceptar'),
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop("Discard");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  MyHomePage(title: "TurnAR")));
                            // TODO: debe eliminar el turno
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
              },
              child: const Text('Eliminar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            ),
          ],
        ),
      ),
    );
  }
}