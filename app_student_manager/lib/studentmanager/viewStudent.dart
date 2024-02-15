import 'package:app_student_manager/model/student.dart';
import 'package:app_student_manager/navbar/navbar.dart';
import 'package:app_student_manager/studentmanager/updateStudent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewStudent extends StatefulWidget {
  final Student student;

  ViewStudent({required this.student});

  @override
  State<StatefulWidget> createState() {
    return ViewStudentState(student: student);
  }
}

class ViewStudentState extends State<ViewStudent> {
  final Student student;

  ViewStudentState({required this.student});

  Future<void> _deleteStudent() async {
    final response = await http.delete(Uri.parse(
        'http://192.168.1.9:9090/removeStudent/${student.id.value.toString()}'));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student delete successfully')));
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete student')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ${student.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Phone: ${student.phone}'),
            Text('Email: ${student.email}'),
            Text('Age: ${student.age}'),
            Text('Sex: ${student.sex}'),
            Text('Address: ${student.address}'),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateStudent(student: student)));
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.pink),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: _deleteStudent,
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.black))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
