import 'package:flutter/material.dart';
import 'package:flutter_blog_app/Authentication.dart';
import 'package:flutter_blog_app/LoginRegisterPage.dart';
import 'package:firebase_database/firebase_database.dart';
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
  var userId, pic, username, bio, location;

  // @override
  // void initState() {
  //   print("im here");
  //   super.initState();
  //   DatabaseReference userInfoRef =
  //       FirebaseDatabase.instance.reference().child("UserInfo");
  //   userInfoRef.once().then((DataSnapshot snap) {
  //     var discData = snap.value;

  //     //get user id:
  //     // userId = AuthImplementation.getCurrentUser().then(onValue)

  //     AuthImplementation.getCurrentUser().then((firebaseUserId) {
  //       userId = firebaseUserId;
  //       pic = discData[userId]["pic"];
  //       username = discData[userId]["username"];
  //       bio = discData[userId]["bio"];
  //       location = discData[userId]["location"];
  //       print("user: " + userId);
  //       print(bio);
  //       print(pic);
  //     });
  //     //String email = discData[userId]["email"];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("My Profile"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            // action button
            IconButton(
              icon: new Icon(Icons.exit_to_app),
              onPressed: logoutUser,
            ),
          ]),
      body: getProfileInfo(),
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

  Widget getProfileInfo() {
    var currentUser = AuthImplementation.currentUser;
    print("poop");
    print(currentUser);
    return new FutureBuilder(
        future: FirebaseDatabase.instance
            .reference()
            .child("UserInfo")
            .child(currentUser)
            .once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            //lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;

            pic = values["pic"];
            username = values["username"];
            bio = values["bio"];
            location = values["location"];
            print(bio);
            print(pic);
            return new Card(
              elevation: 10.0,
              margin: EdgeInsets.all(15.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  image: new NetworkImage(pic)))),
                      new SizedBox(
                        height: 3.0,
                      ),
                      new Container(
                        width: 100.0,
                        height: 30,
                        child: new FlatButton(
                          child: Text('Change Pic',
                              style: TextStyle(fontSize: 10)),
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
                                "@" + username,
                                style: Theme.of(context).textTheme.headline,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                location,
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
                        bio,
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
            );
          }
          return CircularProgressIndicator();
        });
  }
}

// userInfoRef.once().then((DataSnapshot snap) {
//       var discData = snap.value;

//       //get user id:
//       // userId = AuthImplementation.getCurrentUser().then(onValue)

//       AuthImplementation.getCurrentUser().then((firebaseUserId) {
//         userId = firebaseUserId;
//         pic = discData[userId]["pic"];
//         username = discData[userId]["username"];
//         bio = discData[userId]["bio"];
//         location = discData[userId]["location"];
//         print("user: " + userId);
//         print(bio);
//         print(pic);
//       });

// new ListView.builder(
//     shrinkWrap: true,
//     itemCount: lists.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("Name: " + lists[index]["name"]),
//             Text("Age: " + lists[index]["age"]),
//             Text("Type: " + lists[index]["type"]),
//           ],
//         ),
//       );
//     });
