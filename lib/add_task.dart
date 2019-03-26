import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/todolist.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  var person =TaskPerson();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Nama tidak boleh kosong';
                    }
                  },
                  onSaved: (value)=> person.nama = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Tugas'
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Tugas tidak boleh kosong';
                    }
                  },
                  onSaved: (value)=> person.tugas = value,
                ),
                RaisedButton(
                  child: Text('kirim'),
                  onPressed: (){
                    createData();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void createData() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      DocumentReference ref = await Firestore.instance.collection('todolist').add({'name': person.nama , 'task':person.tugas});
      setState(() {
       person.id = ref.documentID;
       
      });
    }
  }
}