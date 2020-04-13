
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/ProfilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class EditProfilePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  File sampleImage;
  String _myBio;
  String _myUsername;
  String url;
  final formKey = new GlobalKey<FormState>();
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Profile Images");

      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image Url = " + url);
      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "username": _myUsername,
      "image": url,
      "bio": _myBio,
    };
    ref.child("UserInfo").push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new ProfilePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Choose Profile Picture"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("Select an Image") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
        child: new Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 330.0, width: 660.0),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Username'),
              validator: (value) {
                return value.isEmpty ? 'Username is required' : null;
              },
              onChanged: (value) {
                return _myBio = value;
              }),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Bio'),
              validator: (value) {
                return value.isEmpty ? 'Bio is required' : null;
              },
              onChanged: (value) {
                return _myBio = value;
              }),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            elevation: 10.0,
            child: Text('Save Profile Changes'),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: uploadStatusImage,
          ),
        ],
      ),
    ));
  }
}

















// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'HomePage.dart';
// import 'credentials.dart';
// import 'package:dio/dio.dart';

// class EditProfilePage extends StatefulWidget {
//   State<StatefulWidget> createState() {
//     return _EditProfilePageState();
//   }
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   String _myBio = " ";
//   String _myUsername = " ";
//   String url;
//   final formKey = new GlobalKey<FormState>();

//   bool validateAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void saveToDatabase() {
//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     var data = {
//       "username": _myUsername,
//       "bio": _myBio,
//     };
//     ref.child("UserInfo").push().set(data);
//     goToHomePage();
//   }

//   void goToHomePage() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return new HomePage();
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Save Changes to Profile"),
//         centerTitle: true,
//       ),
//       body: new Center(child: enableUpload()),
//     );
//   }

//   Widget enableUpload() {
//     return Container(
//         child: new Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//               decoration: new InputDecoration(labelText: 'Username'),
//               validator: (value) {
//                 return value.isEmpty ? 'Username is required' : null;
//               },
//               onChanged: (value) {
//                 _myUsername = value;
//               }),
//           TextFormField(
//               decoration: new InputDecoration(labelText: 'Bio'),
//               validator: (value) {
//                 return value.isEmpty ? 'Bio is required' : null;
//               },
//               onChanged: (value) {
//                 _myBio = value;
//               }),
//           RaisedButton(
//             elevation: 10.0,
//             child: Text('Update Profile'),
//             textColor: Colors.white,
//             color: Colors.pink,
//             onPressed: saveToDatabase,
//           ),
//         ],
//       ),
//     ));
//   }
// }
