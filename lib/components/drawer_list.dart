import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Usuario"),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF3383CD), Color(0xFF12249F)]),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png"),
              ),
              accountEmail: Text("teste@gmail.com"),
            ),
            ListTile(
              title: Text("Casos confirmados"),
              leading: Icon(Icons.people_outline),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text("Quiz COVID-19"),
              leading: Icon(Icons.healing),
              trailing: Icon(Icons.announcement),
            ),
            ListTile(
              title: Text("Preciso de ajuda médica?"),
              leading: Icon(Icons.help),
            ),
            ListTile(
              title: Text("Sobre o APP"),
              leading: Icon(Icons.info),
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
            ),

          ],
        ),
      ),
    );
  }
}
