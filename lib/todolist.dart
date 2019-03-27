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
  void initState() {
    super.initState();
    loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: listPerson.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(listPerson[index].nama),
              subtitle: Text(listPerson[index].tugas),
              // method yang lebih aman utk memanggil 
              //title: Text("${listPerson[index].nama}"),
              //subtitle: Text("${listPerson[index].tugas}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTask()));
        },
      ),
    );
  }

  void loadTask(){
    Firestore.instance.collection('todolist').snapshots().listen((value){
      List<TaskPerson> taskPerson = value.documents.map((doc)=> TaskPerson.fromDocument(doc)).toList();

      setState(() {
       listPerson = taskPerson;
      });
    });
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