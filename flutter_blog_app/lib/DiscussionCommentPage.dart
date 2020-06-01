import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Authentication.dart';
import 'Comment.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';

class DiscussionCommentPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiscussionCommentPageState();
  }
}

class _DiscussionCommentPageState extends State<DiscussionCommentPage> {
  String discussionID = "-M4SAApkAF5mnBING1IH";
  String _myComment = "";
  var posterUserID, bodyText, title, time, comments, likes;

  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //print(getCurrentUser());
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return new HomePage();
              }),
            );
          },
        ),
        title: new Text("Comments"),
        centerTitle: true,
      ),
      body: combined(),
    );
  }

  Widget combined() {
    return new FutureBuilder(
        future: FirebaseDatabase.instance
            .reference()
            .child("Discussions")
            .child(discussionID)
            .once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            //lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            posterUserID = values["userId"];
            bodyText = values["bodyText"];
            title = values["title"];
            time = values["time"];
            comments = values["comments"];
            List<Comment> commentsList = [];
            if (comments != null) {
              comments
                  .forEach((id, commentVals) => commentsList.add(new Comment(
                        commentVals['userId'],
                        commentVals['commentBody'],
                        commentVals['time'],
                      )));
            }
            return new Column(children: <Widget>[
              discussionUI(posterUserID, title, bodyText, time),
              new Container(
                  height: 250.0,
                  child: commentsList.length == 0
                      ? new Text("No Comments yet")
                      : new ListView.builder(
                          itemCount: commentsList.length,
                          itemBuilder: (_, index) {
                            return commentsUI(
                                commentsList[index].userId,
                                commentsList[index].commentBody,
                                commentsList[index].time);
                          },
                        )),
              new Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: new InputDecoration(labelText: 'Comment'),
                        validator: (value) {
                          return value.isEmpty
                              ? 'Please enter a comment'
                              : null;
                        },
                        onChanged: (value) {
                          return _myComment = value;
                        }),
                    RaisedButton(
                      elevation: 10.0,
                      child: Text('Add Comment'),
                      textColor: Colors.white,
                      color: Colors.grey,
                      onPressed: saveToDatabase,
                    ),
                  ],
                ),
              )
            ]);
          }
          return CircularProgressIndicator();
        });
  }

  void saveToDatabase() {
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat.yMMMMd("en_US").add_jm();

    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "userId": AuthImplementation.currentUser,
      "commentBody": _myComment,
      "time": time,
    };
    ref.child("Discussions").child(discussionID).child("comments").push().set(data);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new DiscussionCommentPage();
    }));
  }

  Widget discussionUI(
      String username, String title, String bodyText, String time) {
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
                  "username",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ]),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                title,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          new Text(
            bodyText,
            style: Theme.of(context).textTheme.bodyText2,
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
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.right,
              ),
              //Note: all the buttons below do not have functionality yet. when pressed they do nothing
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
                      return new DiscussionCommentPage();
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
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                new SizedBox(width: 6.0),
              ]),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                commentBody,
                style: Theme.of(context).textTheme.bodyText1,
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
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

