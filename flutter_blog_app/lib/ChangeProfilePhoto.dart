
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/ProfilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ChangeProfilePhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ChangeProfilePhotoPageState();
  }
}

class _ChangeProfilePhotoPageState extends State<ChangeProfilePhotoPage> {
  File sampleImage;
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
      "image": url,
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
          RaisedButton(
            elevation: 10.0,
            child: Text('Change Profile Picture'),
            textColor: Colors.white,
            color: Colors.pink,
            onPressed: uploadStatusImage,
          ),
        ],
      ),
    ));
  }
}
