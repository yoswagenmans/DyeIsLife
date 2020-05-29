import 'package:flutter/material.dart';
import 'Mapping.dart';
//import 'Authentication.dart';

void main() {
  runApp(new BlogApp());
}

final Map<int, Color> munsellblue = {
  50: Color.fromRGBO(72, 170, 189, .1),
  100: Color.fromRGBO(72, 170, 189, .2),
  200: Color.fromRGBO(72, 170, 189, .3),
  300: Color.fromRGBO(72, 170, 189, .4),
  400: Color.fromRGBO(72, 170, 189, .5),
  500: Color.fromRGBO(72, 170, 189, .6),
  600: Color.fromRGBO(72, 170, 189, .7),
  700: Color.fromRGBO(72, 170, 189, .8),
  800: Color.fromRGBO(72, 170, 189, .9),
  900: Color.fromRGBO(72, 170, 189, 1),
};
final Map<int, Color> darkgray = {
  50: Color.fromRGBO(70, 73, 76, .1),
  100: Color.fromRGBO(70, 73, 76, .2),
  200: Color.fromRGBO(70, 73, 76, .3),
  300: Color.fromRGBO(70, 73, 76, .4),
  400: Color.fromRGBO(70, 73, 76, .5),
  500: Color.fromRGBO(70, 73, 76, .6),
  600: Color.fromRGBO(70, 73, 76, .7),
  700: Color.fromRGBO(70, 73, 76, .8),
  800: Color.fromRGBO(70, 73, 76, .9),
  900: Color.fromRGBO(70, 73, 76, 1),
};

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFF48AABD, munsellblue);
    final MaterialColor colorCustom2 = MaterialColor(0xFF46494C, darkgray);
    var themeData = new ThemeData(
        primarySwatch: colorCustom2,
        bottomAppBarColor: colorCustom,
        fontFamily: 'OpenSans',
      );
    return new MaterialApp(
      title: "Blog App",
      theme: themeData,
      home: MappingPage(),
    );
  }
}
