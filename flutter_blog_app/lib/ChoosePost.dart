import 'package:flutter/material.dart';
import 'DiscussionUpload.dart';
import 'PhotoUpload.dart';
//import 'package:image_picker/image_picker.dart';

class ChoosePostPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _ChoosePostPageState();
  }
}

class _ChoosePostPageState extends State<ChoosePostPage> {
  @override
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Post"),
        centerTitle: true,
      ),
      body: new Column(children: <Widget>[
        new SizedBox(height: 30),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.message),
              iconSize: 30,
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return new UploadDiscussionPage();
                  }),
                );
              },
            ),
            new IconButton(
              icon: new Icon(Icons.add_a_photo),
              iconSize: 30,
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return new UploadPhotoPage();
                  }),
                );
              },
            ),
          ],
        )
      ]),

      // floatingActionButton: new FloatingActionButton(
      //   onPressed: getImage,
      //   tooltip: 'Add Image',
      //   child: new Icon(Icons.add_a_photo),
      // ),
    );
  }

}