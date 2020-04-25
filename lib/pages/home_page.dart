


import 'package:flutter/material.dart';
import 'package:healthcare/components/drawer_list.dart';
import 'package:healthcare/pages/info_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12249F),
        title: Text("Health Care ",
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
      body: InfoPage(),
      drawer: DrawerList(),
    );
  }
}
