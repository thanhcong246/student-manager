import 'package:app_student_manager/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../studentmanager/addStudent.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return navbarStudentState();
  }
}

class navbarStudentState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Student Manager'),
      ),
      body: Home(),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 10.0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  'Function Student',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ListTile(
              title: const Text('Add Student'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStudent()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
