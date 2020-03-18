import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';
import 'PhotoUpload.dart';
import 'Posts.dart';


class HomePage extends StatefulWidget {
  HomePage({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut; 


  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  
  //The list with all the different posts in it 
  List<Posts> postsList = [];

  //This message will be called everytime the user visits
  //the homepage. within this message we will retrieve posts
  //from the database
  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value; 

      postsList.clear();
      for(var individualKey in KEYS)
      {
        Posts posts = new Posts(
          DATA[individualKey]['image'], 
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );
        postsList.add(posts);
      }
        setState(() 
        {
          print('Length: $postsList.length');
        });
    });
  }


  void _logoutUser() async{
    try{
      await widget.auth.signOut(); 
      widget.onSignedOut();
    }
    catch(e)
    {
      print(e.toString()); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        child: postsList.length == 0 ? new Text("No Posts available"): new ListView.builder
        (
          itemCount: postsList.length,
          itemBuilder: (_, index)
          {
            return PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time);
          },

        )
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.teal,
        child: new Container(
            margin: const EdgeInsets.only(left: 70.0, right: 70.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.exit_to_app),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: _logoutUser,
                ),
                new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: ( )
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new UploadPhotoPage(); 
                      }),
                    );

                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget PostsUI(String image, String description, String date, String time)
  {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>
              [
                  new Text(
                    "@henryhevans", 
                    style: Theme.of(context).textTheme.subhead,
                    textAlign: TextAlign.center,
                    
                  ),
                  new Text(
                    "Seattle, WA", 
                    style: Theme.of(context).textTheme.subtitle, 
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
            SizedBox(height:3.0,),

            new Image.network(image, fit: BoxFit.cover),
            SizedBox(height:5.0,),
            new Text(
                  description, 
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
            ),
            SizedBox(height:5.0,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>
              [
                  new Text(
                    date, 
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                    
                  ),
                  new Text(
                    "   ", 
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.right,
                    
                  ),
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
                    onPressed: _logoutUser,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.insert_comment),
                    iconSize: 25,
                    color: Colors.teal,
                    onPressed: _logoutUser,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.mobile_screen_share),
                    iconSize: 25,
                    color: Colors.teal,
                    onPressed: _logoutUser,
                  ),
              ],
            ),
        ],
      ),


    );
  }
}