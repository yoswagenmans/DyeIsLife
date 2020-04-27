import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'HomePage.dart';

class UploadDiscussionPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadDiscussionPageState();
  }
}

class _UploadDiscussionPageState extends State<UploadDiscussionPage> {
  String _myBody = " ";
  String _myTitle = " ";
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
    print("body text=" + _myBody);
    print(_myTitle);
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat.yMMMMd("en_US").add_jm();

    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "userId": AuthImplementation.currentUser,
      "title": _myTitle,
      "bodyText": _myBody,
      "time": time,
    };
    ref.child("Discussions").push().set(data);
    goToHomePage();
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Discussion"),
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
              decoration: new InputDecoration(labelText: 'Title'),
              validator: (value) {
                return value.isEmpty ? 'Title is required' : null;
              },
              onChanged: (value) {
                _myTitle = value;
              }),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Body'),
              validator: (value) {
                return value.isEmpty ? 'Body is required' : null;
              },
              onChanged: (value) {
                _myBody = value;
              }),
          RaisedButton(
            elevation: 10.0,
            child: Text('Add a New Discussion Post'),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: saveToDatabase,
          ),
        ],
      ),
    ));
  }
}
