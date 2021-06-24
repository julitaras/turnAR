import 'package:app_turnar/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInButton extends StatefulWidget {
  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool _isProcessing = false;
  late User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isSignIn = false;
  bool google = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blueGrey, width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          signInWithGoogle().then((User user) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyHomePage(user: user),
              ),
            );
            // ignore: invalid_return_type_for_catch_error
          }).catchError((error) => print('Registration Error: $error'));

          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Iniciar sesión con Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await account!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await _auth.signInWithCredential(credential);

    _user = authResult.user!;

    assert(!_user.isAnonymous);

    User currentUser = _auth.currentUser!;

    assert(_user.uid == currentUser.uid);

    return _user;
  }
}
