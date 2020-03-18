import 'package:flutter/material.dart';
import 'Mapping.dart'; 
import 'Authentication.dart';

void main() {
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MappingPage(auth: Auth(),),
    );
  }
}
