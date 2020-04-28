import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Authentication.dart';
import 'ProfilePage.dart';
//import 'Authentication.dart';

class EditProfilePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _myUsername = " ";
  String _myBio = " ";
  String _myLocation = " ";
  String url;
  final formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void saveToDatabase() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "username": _myUsername,
      "location": _myLocation,
      "bio": _myBio,
    };
    ref.child("UserInfo").child(AuthImplementation.currentUser).update(data);
    goToProfilePage();
  }

  void goToProfilePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new ProfilePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    //print(getCurrentUser());
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Profile"),
        centerTitle: true,
      ),
      body: new Center(child: enableUpload()),
    );
  }

  Widget enableUpload() {
    return Container(
        child: new Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              decoration: new InputDecoration(labelText: 'Username'),
              validator: (value) {
                return value.isEmpty ? 'Username is required' : null;
              },
              onChanged: (value) {
                _myUsername = value;
              }),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Location'),
              // validator: (value) {
              //   return value.isEmpty ? 'Username is required' : null;
              // },
              onChanged: (value) {
                _myLocation = value;
              }),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Bio'),
              validator: (value) {
                return value.isEmpty ? 'Bio is required' : null;
              },
              onChanged: (value) {
                _myBio = value;
              }),
          RaisedButton(
            elevation: 10.0,
            child: Text('Save profile changes'),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: saveToDatabase,
          ),
        ],
      ),
    ));
  }
}


