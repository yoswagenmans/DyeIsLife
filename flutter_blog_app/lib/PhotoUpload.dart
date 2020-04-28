
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'HomePage.dart';
import 'credentials.dart';
import 'package:dio/dio.dart';
import 'Authentication.dart';

class UploadPhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  String _myValue;
  String _myLocation;
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
          FirebaseStorage.instance.ref().child("Post Images");

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
    var dbTimeKey = new DateTime.now();
    var formatTime = new DateFormat.yMMMMd("en_US").add_jm();

    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "userId": AuthImplementation.currentUser,
      "username": "@henryhevans",
      "image": url,
      "description": _myValue,
      "location": _myLocation,
      "time": time,
    };
    ref.child("Posts").push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Image"),
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
//The String input is what the user is searching. This function is called once they begin to type
void getLocationResults(String input) async
{
  //String type = '(regions)'; //The type determines what it returns. I can change this later
  String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String request = '$baseUrl?input=$input&key=$PLACES_API_KEY'; //If I want to include type filter I would add &type=$type
  Response response = await Dio().get(request);

  final predictions = response.data['predictions'];
  List<String> _displayResults = []; 
  for (var i = 0; i < predictions.length; i ++)
  {
    String name = predictions[i]['description'];
    _displayResults.add(name);
  }
  print(_displayResults);
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
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Description is required' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              }),
          TextFormField(
              decoration: new InputDecoration(labelText: 'Location'),
              validator: (value) {
                return value.isEmpty ? 'location is required' : null;
              },
              onChanged: (text){
                getLocationResults(text); 
              },
              onSaved: (value) {
                return _myLocation = value;
              }),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            elevation: 10.0,
            child: Text('Add a New Post'),
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
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'HomePage.dart';
// import 'credentials.dart';
// import 'package:dio/dio.dart';
// import 'DiscussionUpload.dart';

// class UploadPhotoPage extends StatefulWidget {
//   State<StatefulWidget> createState() {
//     return _UploadPhotoPageState();
//   }
// }

// class _UploadPhotoPageState extends State<UploadPhotoPage> {
//   File sampleImage;
//   String _myValue;
//   String _myLocation;
//   String url;
//   final formKey = new GlobalKey<FormState>();
//   Future getImage() async {
//     var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       sampleImage = tempImage;
//     });
//   }

//   bool validateAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   void uploadStatusImage() async {
//     if (validateAndSave()) {
//       final StorageReference postImageRef =
//           FirebaseStorage.instance.ref().child("Post Images");

//       var timeKey = new DateTime.now();
//       final StorageUploadTask uploadTask =
//           postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

//       var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
//       url = imageUrl.toString();
//       print("Image Url = " + url);
//       goToHomePage();
//       saveToDatabase(url);
//     }
//   }

//   void saveToDatabase(url) {
//     var dbTimeKey = new DateTime.now();
//     var formatTime = new DateFormat.yMMMMd("en_US").add_jm();

//     String time = formatTime.format(dbTimeKey);

//     DatabaseReference ref = FirebaseDatabase.instance.reference();
//     var data = {
//       "username": "@henryhevans",
//       "image": url,
//       "description": _myValue,
//       "location": _myLocation,
//       "time": time,
//     };
//     ref.child("Posts").push().set(data);
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
//         title: new Text("Create Post"),
//         centerTitle: true,
//       ),
//       body: new Column(children: <Widget>[
//         sampleImage == null ? Text("Select an Image") : enableUpload(),
//         new Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             new FloatingActionButton(
//               onPressed: getImage,
//               tooltip: 'Add Image',
//               child: new Icon(Icons.add_a_photo),
//             ),
//           ],
//         )
//       ]),

//       // floatingActionButton: new FloatingActionButton(
//       //   onPressed: getImage,
//       //   tooltip: 'Add Image',
//       //   child: new Icon(Icons.add_a_photo),
//       // ),
//     );
//   }

// //The String input is what the user is searching. This function is called once they begin to type
//   void getLocationResults(String input) async {
//     //String type = '(regions)'; //The type determines what it returns. I can change this later
//     String baseUrl =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseUrl?input=$input&key=$PLACES_API_KEY'; //If I want to include type filter I would add &type=$type
//     Response response = await Dio().get(request);

//     final predictions = response.data['predictions'];
//     List<String> _displayResults = [];
//     for (var i = 0; i < predictions.length; i++) {
//       String name = predictions[i]['description'];
//       _displayResults.add(name);
//     }
//     print(_displayResults);
//   }

//   Widget enableUpload() {
//     return Container(
//         child: new Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           Image.file(sampleImage, height: 330.0, width: 660.0),
//           SizedBox(
//             height: 15.0,
//           ),
//           TextFormField(
//               decoration: new InputDecoration(labelText: 'Description'),
//               validator: (value) {
//                 return value.isEmpty ? 'Description is required' : null;
//               },
//               onSaved: (value) {
//                 return _myValue = value;
//               }),
//           TextFormField(
//               decoration: new InputDecoration(labelText: 'Location'),
//               validator: (value) {
//                 return value.isEmpty ? 'location is required' : null;
//               },
//               onChanged: (text) {
//                 getLocationResults(text);
//               },
//               onSaved: (value) {
//                 return _myLocation = value;
//               }),
//           SizedBox(
//             height: 15.0,
//           ),
//           RaisedButton(
//             elevation: 10.0,
//             child: Text('Add a New Post'),
//             textColor: Colors.white,
//             color: Colors.pink,
//             onPressed: uploadStatusImage,
//           ),
//         ],
//       ),
//     ));
//   }
// }
