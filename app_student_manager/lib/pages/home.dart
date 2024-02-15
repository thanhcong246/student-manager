import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/student.dart';
import '../studentmanager/viewStudent.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homeStudentState();
  }
}

class homeStudentState extends State<Home> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _getAllStudents();
  }

  Future<void> _getAllStudents() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9:9090/students'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        students = data.map((e) => Student.fromJson(e)).toList();
      });
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final student = students[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewStudent(student: student)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("STT: ${index + 1}"),
                      Text(student.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Phone: ${student.phone}'),
                      Text('Email: ${student.email}'),
                      Text('Age: :${student.age}'),
                      Text('Sex: ${student.sex}'),
                      Text('Address: ${student.address}'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: students.length,
            ),
          ),
        ),
      ],
    );
  }
}
