import 'package:app_turnar/pages/my_appointments.dart';
import 'package:app_turnar/widgets/sign_out_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mi perfil"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(40.0, 40, 40, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          color: Colors.red,
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _user.displayName!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${_user.email!}',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyAppointments(user: _user,)));
                    },
                    child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                      width: double.infinity,
                      child: Text(
                        '\nVer Mis Turnos',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ),
                  ),
                ),
                Container(
                  height: 200.0,
                ),
                Container(
                  height: 1.0,
                  width: 150,
                  color: Colors.grey,
                ),
                Container(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                child: SignOutButton(),
                ),
              ],
            ),
          ),
        ));
  }
}
