import 'package:database_crud/databse.dart';
import 'package:flutter/material.dart';

class InsertStudent extends StatefulWidget {
  InsertStudent({super.key, this.map});

  Map? map;
  @override
  State<InsertStudent> createState() => _InsertStudentState();
}

class _InsertStudentState extends State<InsertStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  MyDatabase db = MyDatabase();

  @override
  void initState() {
    super.initState();
    nameController.text =
        widget.map?['name'] == null ? "" : widget.map!['name'];
    emailController.text =
        widget.map?['email'] == null ? "" : widget.map!['email'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: "email"),
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.map == null) {
                  db.insertData(
                          name: nameController.text,
                          email: emailController.text)
                      .then((value) {
                    Navigator.of(context).pop(true);
                  });
                } else {
                  db.updateData(
                          name: nameController.text,
                          email: emailController.text,
                          id: widget.map!['studentID'])
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
