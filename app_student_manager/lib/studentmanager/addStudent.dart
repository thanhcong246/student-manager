import 'dart:convert';

import 'package:app_student_manager/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/student.dart';

class AddStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addStudentState();
  }
}

Future<Student> addStudent(BuildContext context, String name, String phone,
    String email, int age, String sex, String address) async {
  var Url = Uri.parse("http://192.168.1.9:9090/addStudent");
  var response = await http.post(Url,
      headers: <String, String>{
        "Content-Type": "application/json; charset=utf-8"
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "phone": phone,
        "email": email,
        "age": age.toString(),
        "sex": sex,
        "address": address
      }));
  if (response.statusCode == 200) {
    _navigateToHomeAndRefresh(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Add Student', content: response.body);
      },
    );
    return Student(
        id: Long(0),
        name: name,
        phone: phone,
        email: email,
        sex: sex,
        age: age,
        address: address);
  } else {
    throw Exception('failed to add student');
  }
}

void _navigateToHomeAndRefresh(BuildContext context) {
  Navigator.pop(context);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Navbar()));
}

class addStudentState extends State<AddStudent> {
  String? gender = 'male';

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameTxt = TextEditingController();
  TextEditingController phoneTxt = TextEditingController();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController ageTxt = TextEditingController();
  TextEditingController addressTxt = TextEditingController();

  late Student studentmodel;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleSmall;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String name = nameTxt.text;
                      String phone = phoneTxt.text;
                      String email = emailTxt.text;
                      String address = addressTxt.text;
                      String ageString = ageTxt.text;
                      int age = 0;
                      if (ageString.isNotEmpty) {
                        age = int.tryParse(ageString) ?? 0;
                      }
                      Student studentAdd = await addStudent(
                          context, name, phone, email, age, gender!, address);
                      nameTxt.text = '';
                      phoneTxt.text = '';
                      emailTxt.text = '';
                      ageTxt.text = '';
                      addressTxt.text = '';
                      setState(() {
                        studentmodel = studentAdd;
                      });
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    ));
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      actions: actions,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
