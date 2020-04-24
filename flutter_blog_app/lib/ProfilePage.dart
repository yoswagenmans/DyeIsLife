import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';
import 'package:flutter_blog_app/LoginRegisterPage.dart';
import 'infoPage.dart';
import 'HomePage.dart';
import 'EditProfile.dart';
import 'ChangeProfilePhoto.dart';
//import 'Mapping.dart';
import 'Authentication.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    //this.auth,
    this.onSignedOut,
  });
  //final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //print("test 11 " + AuthImplementation.getCurrentUser().toString());
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("MY Profile"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            // action button
            IconButton(
              icon: new Icon(Icons.exit_to_app),
              onPressed: logoutUser,
            ),
          ]),

      body: new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 20.0,
            ),
            new Row(children: <Widget>[
              new SizedBox(
                width: 20.0,
              ),
              new Column(children: <Widget>[
                new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://www.nwchess.com/articles/events/2011/images/WJOR_2011_Yos.JPG")))),
                new SizedBox(
                  height: 3.0,
                ),
                new Container(
                  width: 100.0,
                  height: 30,
                  child: new FlatButton(
                    child: Text('Change Pic', style: TextStyle(fontSize: 10)),
                    color: Color.fromRGBO(52, 52, 53, 1),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return new ChangeProfilePhotoPage();
                        }),
                      );
                    },
                  ),
                ),
              ]),
              new SizedBox(
                width: 50.0,
              ),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "@yosfanpage",
                          style: Theme.of(context).textTheme.headline,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Seattle, WA",
                          style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ])
            ]),
            new SizedBox(
              height: 20.0,
            ),
            new SizedBox(
              height: 5.0,
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "I have been worshipping Yos for the past two years. He has blocked me on all forms of social media so this is the only way I can contact him",
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
                new SizedBox(
                  height: 10.0,
                ),
                new Container(
                  width: 300,
                  child: new FlatButton(
                    child: Text('Edit Profile'),
                    color: Color.fromRGBO(52, 52, 53, 1),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return new EditProfilePage();
                        }),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      //  new CircleAvatar(
      //     backgroundColor: Colors.transparent,
      //     radius: 50.0,
      //     child: Image.asset('images/app_logo.jpeg'),
      //   ),
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
    );
  }

  void logoutUser() async {
    try {
      await AuthImplementation.signOut();
      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return new LoginRegisterPage();
                      }),
                    );

    } catch (e) {
      print(e.toString());
    }
  }
}
