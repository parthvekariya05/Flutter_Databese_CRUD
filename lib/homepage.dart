import 'package:database_crud/adduser.dart';
import 'package:database_crud/databse.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InsertStudent();
                },
              )).then((value) {
                if (value == true) {
                  setState(() {});
                }
              });
            },
            child: Container(
                child: Icon(Icons.add),
                margin: EdgeInsets.only(right: 10),
                height: 20),
          )
        ],
      ),
      body: FutureBuilder(
        future: db.getAllUser(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            return FutureBuilder(
              future: db.getAllUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return InsertStudent(
                                  map: snapshot.data![index],
                                );
                              },
                            )).then((value) {
                              setState(() {});
                            });
                          },
                          tileColor: Colors.grey,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index]["name"].toString(),
                                  style: TextStyle(fontSize: 25)),
                              Text(snapshot.data![index]["email"].toString())
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              db.deleteData(int.parse(snapshot.data![index]['studentID'].toString())).then((value) {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Data not found"),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
