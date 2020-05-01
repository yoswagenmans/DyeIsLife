import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Authentication.dart';
import 'ProfilePage.dart';
//import 'Authentication.dart';

class CommentPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //print(getCurrentUser());
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Comments"),
        centerTitle: true,
      ),
      body: combined(),
    );
  }

  Widget combined() {
    return new Column(children: <Widget>[
      postsUI(
          "example1",
          "https://firebasestorage.googleapis.com/v0/b/blogapp-ece3e.appspot.com/o/Profile%20Images%2FScreen%20Shot%202020-04-26%20at%205.07.11%20PM.png?alt=media&token=39ad6760-abae-4142-8f75-619213fce9e9",
          "caption will go here",
          "Seattle, WA",
          "April 25th, 2020 9:30 PM"),
      commentsUI("@HenryE", "Carol Baker is hot", "April 26, 2020 10:41 PM"),
      commentsUI("@JoeJoeR", "80085", "April 26, 2020 10:41 PM"),
      commentsUI("@Yos", "yos", "April 26, 2020 10:41 PM"),
      new Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              decoration: new InputDecoration(labelText: 'Comment'),
              validator: (value) {
                return value.isEmpty ? 'Please enter a comment' : null;
              },
              onSaved: (value) {
                return null; //_myValue = value;
              }),
          RaisedButton(
            elevation: 10.0,
            child: Text('Add Comment'),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: null,
          ),
        ],
      ),
    )
      //commentsUI("@AlexJKB", "Happy early fathers day, Henry. You are the best daddy I could ever ask for", "April 26, 2020 10:41 PM"),
    ]);
  }

  Widget postsUI(String username, String image, String description,
      String location, String time) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                username,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
              new Text(
                location,
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          new Image.network(image, fit: BoxFit.cover),
          SizedBox(
            height: 5.0,
          ),
          new Text(
            description,
            style: Theme.of(context).textTheme.subhead,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                time,
                style: Theme.of(context).textTheme.subtitle,
                textAlign: TextAlign.right,
              ),
              //Note: al the buttons below do not have functionality yet. when pressed they will simply sign
              //the user out instead of their intended function
              new IconButton(
                icon: new Icon(Icons.favorite_border),
                iconSize: 25,
                color: Colors.teal,
                onPressed: null, //Ability to like will be added later on
              ),
              new IconButton(
                icon: new Icon(Icons.insert_comment),
                iconSize: 25,
                color: Colors.teal,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return new CommentPage();
                    }),
                  );
                }, //ability to comment later on
              ),
              new IconButton(
                icon: new Icon(Icons.mobile_screen_share),
                iconSize: 25,
                color: Colors.teal,
                onPressed: null, //have option to share later on
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commentsUI(String username, String commentBody, String time) {
    return new Card(
      elevation: 10.0,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 3.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                username,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
              new SizedBox(width: 6.0),
              new Text(
                commentBody,
                style: Theme.of(context).textTheme.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                time,
                style: Theme.of(context).textTheme.body2,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
