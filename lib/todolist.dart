import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_task.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  var listPerson = List<TaskPerson>(); // membuat variable list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTask()));
        },
      ),
    );
  }
}

class TaskPerson{
  var id;
  var nama;
  var tugas;

  static TaskPerson fromDocument(DocumentSnapshot doc) {
    TaskPerson taskP = TaskPerson();
    taskP.id = doc.documentID;
    taskP.nama = doc.data['name'];
    taskP.tugas = doc.data['task'];

    return taskP;
  }
}