import 'package:flutter/material.dart';

class DiscussionCommentPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiscussionCommentPageState();
  }
}

class _DiscussionCommentPageState extends State<DiscussionCommentPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Discussion"),
        centerTitle: true,
      ),
      body: combined(),
    );
  }

  Widget combined() {
    return new Column(children: <Widget>[
      discussionUI(
          "example1",
          "Type of Plywood",
          "I was wondering if anyone had recommendations on the best kind of plywood to use while building a table. I want a wood that is durable, easy to paint on, and has good bounce. I would love product recs that I could find at either a Lowes or Home Depot",
          "April 25th, 2020 9:30 PM"),
      commentsUI("@HenryE", "Carol Baker is hot", "April 26, 2020 10:41 PM"),
      commentsUI("@JoeJoeR", "80085", "April 26, 2020 10:41 PM"),
      commentsUI("@Yos", "yos", "April 26, 2020 10:43 PM"),
      
    ]);
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
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
              ]),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                title,
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          new Text(
            bodyText,
            style: Theme.of(context).textTheme.body1,
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
