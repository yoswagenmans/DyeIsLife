import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'Authentication.dart';
// import 'ProfilePage.dart';
import 'Authentication.dart';
import 'Comment.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _CommentPageState();
  }
}

class _CommentPageState extends State<CommentPage> {
  String postID = "-M5u8zi8IikFVUkmtDNk";
  String _myComment = "";
  var pic, posterUserID, description, location, time, comments, likes;

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
    return new FutureBuilder(
        future: FirebaseDatabase.instance
            .reference()
            .child("Posts")
            .child(postID)
            .once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            //lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            pic = values["image"];
            posterUserID = values["userId"];
            description = values["description"];
            time = values["time"];
            location = values["location"];
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
              postsViewUI(posterUserID, pic, description, location, time),
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
                      color: Colors.pink,
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
    ref.child("Posts").child(postID).child("comments").push().set(data);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new CommentPage();
    }));
  }

  Widget postsViewUI(String username, String image, String description,
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
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              new Text(
                location,
                style: Theme.of(context).textTheme.subtitle2,
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
            style: Theme.of(context).textTheme.subtitle1,
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
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              new SizedBox(width: 6.0),
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
