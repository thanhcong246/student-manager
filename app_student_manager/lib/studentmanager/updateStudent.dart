import 'dart:convert';

import 'package:app_student_manager/navbar/navbar.dart';
import 'package:app_student_manager/studentmanager/viewStudent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/student.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;

  UpdateStudent({required this.student});

  @override
  State<StatefulWidget> createState() {
    return UpdateStudentState(student: student);
  }
}

class UpdateStudentState extends State<UpdateStudent> {
  final Student student;

  UpdateStudentState({required this.student});

  String? gender = 'male';

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameTxt;
  late TextEditingController phoneTxt;
  late TextEditingController emailTxt;
  late TextEditingController ageTxt;
  late TextEditingController addressTxt;

  Future<void> _updateStudent(Student student) async {
    try {
      var response = await http.put(
        Uri.parse(
            'http://192.168.1.9:9090/updateStudent/${student.id.value.toString()}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(student.toJson()),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewStudent(student: student)));
        const snackBar = SnackBar(content: Text('Student update successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update student')));
      }
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    nameTxt = TextEditingController(text: student.name);
    phoneTxt = TextEditingController(text: student.phone);
    emailTxt = TextEditingController(text: student.email);
    ageTxt = TextEditingController(text: student.age.toString());
    addressTxt = TextEditingController(text: student.address);
    gender = student.sex;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  controller: nameTxt,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter name';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter name',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.phone,
                  controller: phoneTxt,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter phone';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Enter phone',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  controller: emailTxt,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter email';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.phone,
                  controller: ageTxt,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter age';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter age',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: textStyle,
                  controller: addressTxt,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter address';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter address',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'male',
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'female',
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Student editStudent = Student(
                          name: nameTxt.text,
                          phone: phoneTxt.text,
                          email: emailTxt.text,
                          age: int.parse(ageTxt.text),
                          address: addressTxt.text,
                          sex: gender!,
                          id: student.id);
                      _updateStudent(editStudent);
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    ));
  }
}
