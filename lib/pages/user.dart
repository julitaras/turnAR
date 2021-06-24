import 'package:flutter/material.dart';
import 'package:app_turnar/widgets/sign_out_button.dart';
import 'package:app_turnar/pages/myTurns.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xffe7eaf2),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(40.0, 40, 40, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(10, 15),
                            color: Color(0x22000000),
                            blurRadius: 20.0)
                      ],
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'))),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Sonu Sharma',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 70,
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyTurns()));
                    },
                    child: const SizedBox(
                      width: 600,
                      height: 50,
                      child: Text(
                        '\nVer Mis Turnos',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SignOutButton(),
              ],
            ),
          ),
        ));
  }
}
