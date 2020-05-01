import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Posts.dart';
import 'ProfilePage.dart';
import 'infoPage.dart';
import 'package:flutter/cupertino.dart';
import 'Discussions.dart';
import 'ChoosePost.dart';
import 'CommentPage.dart';
import 'DiscussionCommentPage.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

final Map<int, Widget> logoWidgets = const <int, Widget>{
  0: Text('Social Feed'),
  1: Text('Discussion'),
};

int sharedValue = 0;

class _HomePageState extends State<HomePage> {
  //The list with all the different posts in it

  List<Posts> postsList = [];
  Map<int, Widget> postWidgets;
  //The list with all the different discussions in it
  List<Discussions> discussionsList = [];
  Map<int, Widget> discussionWidgets;
  //This message will be called everytime the user visits
  //the homepage. within this message we will retrieve posts
  //from the database
  @override
  void initState() {
    super.initState();
    AuthImplementation.getCurrentUser();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    DatabaseReference discussionsRef =
        FirebaseDatabase.instance.reference().child("Discussions");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      postsList.clear();
      for (var individualKey in keys) {
        Posts posts = new Posts(
          data[individualKey]['username'],
          data[individualKey]['image'],
          data[individualKey]['description'],
          data[individualKey]['location'],
          data[individualKey]['time'],
        );
        postsList.add(posts);
      }
    });
    discussionsRef.once().then((DataSnapshot snap) {
      var discKeys = snap.value.keys;
      var discData = snap.value;
      discussionsList.clear();
      for (var individualKey in discKeys) {
        Discussions discussions = new Discussions(
          discData[individualKey]['username'],
          discData[individualKey]['title'],
          discData[individualKey]['bodyText'],
          discData[individualKey]['time'],
        );
        discussionsList.add(discussions);
      }
    });
    setState(() {
      sharedValue = 0;
      print('Length: $postsList.length');
    });
  }

  void logoutUser() async {
    try {
      await AuthImplementation.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // void likePost()
  // {
  //   DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   var data = {
  //     "userID": AuthImplementation.getCurrentUser(),
  //     "liked": true,
  //   };
  //   String postID = "testId";
  //   ref.child("Likes").child(postID).update(data);
  // }
  @override
  Widget build(BuildContext context) {
    postWidgets = getPostWidgets();
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Home"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            // action button
            new IconButton(
              icon: new Icon(Icons.add),
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return new ChoosePostPage();
                  }),
                );
              },
            ),
          ]),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          SizedBox(
            width: 500.0,
            child: CupertinoSegmentedControl<int>(
              children: logoWidgets,
              onValueChanged: (int val) {
                setState(() {
                  sharedValue = val;
                });
              },
              groupValue: sharedValue,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 4.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 4.0,
                ),
                child: postWidgets[sharedValue],
              ),
            ),
          ),
          BottomAppBar(
            child: new Container(
                margin: const EdgeInsets.only(left: 70.0, right: 70.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new IconButton(
                      icon: new Image.asset('images/dyeicon.png'),
                      iconSize: 50,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return new InfoPage();
                          }),
                        );
                      },
                    ),
                    new IconButton(
                      icon: new Icon(Icons.forum),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return new HomePage();
                          }),
                        );
                      },
                    ),
                    new IconButton(
                      icon: new Icon(Icons.person),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return new ProfilePage();
                          }),
                        );
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
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
                "username",
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

// HERE: added in
  Map<int, Widget> getPostWidgets() {
    Map<int, Widget> postWidgets = <int, Widget>{
      0: Center(
          child: new Container(
              child: postsList.length == 0
                  ? new Text("No Posts available")
                  : new ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (_, index) {
                        return postsUI(
                            postsList[index].username,
                            postsList[index].image,
                            postsList[index].description,
                            postsList[index].location,
                            postsList[index].time);
                      },
                    ))),
      1: Center(
          child: new Container(
              child: discussionsList.length == 0
                  ? new Text("No Posts available")
                  : new ListView.builder(
                      itemCount: discussionsList.length,
                      itemBuilder: (_, index) {
                        return discussionUI(
                            discussionsList[index].username,
                            discussionsList[index].title,
                            discussionsList[index].bodyText,
                            discussionsList[index].time);
                      },
                    ))),
    };
    return postWidgets;
  }
}
