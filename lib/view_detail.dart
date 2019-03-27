import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'todolist.dart';

class Detail extends StatefulWidget {

  final TaskPerson person;

  Detail(this.person);

  @override
  _DetailState createState() => _DetailState(this.person);
}

class _DetailState extends State<Detail> {

  TaskPerson person;

  _DetailState(this.person);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Center(
        child: Card(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: person.nama,
                  validator: (value){
                    if(value.isEmpty){
                      return "Nama Tidak boleh Kosong!";
                    }
                  },
                  onSaved: (value){
                    person.nama = value;
                  },
                ),
                TextFormField(
                  initialValue: person.tugas,
                  validator: (value){
                    if(value.isEmpty){
                      return "Tugas Tidak boleh Kosong!";
                    }
                  },
                  onSaved: (value){
                    person.tugas = value;
                  },
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Update"),
                      onPressed: () => updateTask(person),
                    ),
                    RaisedButton(
                      child: Text("Delete"),
                      onPressed: () => deleteTask(person),
                    )
                  ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask(TaskPerson person) async {
    await Firestore.instance.collection('todolist').document(person.id).delete().whenComplete((){
      alertDialog("Berhasil", "Data telah di delete");
    });

    setState(() {
     person.id = null; 
     moveToLastScreen();
    });
  }

  void updateTask(TaskPerson person) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      await Firestore.instance.collection('todolist').document(person.id).updateData({'name': person.nama, 'task': person.tugas}).whenComplete((){
        alertDialog("Berhasil", "Data telah di update");
      });

      setState(() {
       person.nama = person.nama;
       person.tugas = person.tugas; 
      });
    }
  }

  void alertDialog(String title, String msg){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );
    showDialog(context: context, builder: (_) => alertDialog);

  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }
}