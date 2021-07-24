import 'package:app_turnar/pages/Login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutButton extends StatefulWidget {
  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signOutGoogle() async {
    await _googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red[900],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Cerrar sesión',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  title: Text('Cerrar Sesión'),
                  content: Text('¿Está seguro/a de que desea cerrar sesión'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Cancelar'),
                      isDefaultAction: false,
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop("Cancel");
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text('Aceptar'),
                      isDefaultAction: true,
                      onPressed: () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ));
      },
    );
  }
}
