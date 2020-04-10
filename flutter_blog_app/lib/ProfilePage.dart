import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';
import 'infoPage.dart';
import 'HomePage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      
      body: 
       new CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50.0,
          child: Image.asset('images/app_logo.jpeg'),
        ),
        
        // IconButton(
        // icon: new Icon(Icons.exit_to_app),
        // iconSize: 50,
        // color: Colors.teal,
        // onPressed: logoutUser, //Add logoutuser later on
      bottomNavigationBar: new BottomAppBar(
        color: Colors.teal,
        
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
                  onPressed: ( )
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new InfoPage(); 
                      }),
                    );

                  },
                ),
                new IconButton(
                  icon: new Icon(Icons.forum),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: ( )
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new HomePage(); 
                      }),
                    );

                  },
                ),
                new IconButton(
                  icon: new Icon(Icons.person),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: ( )
                  {
                    Navigator.push
                    (
                      context, 
                      MaterialPageRoute(builder: (context)
                      {
                          return new ProfilePage(); 
                      }),
                    );

                  },
                ),
 
              ],
            )),
      ),
      
      
    );
  }
  void logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
