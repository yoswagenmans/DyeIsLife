import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'RulesPage.dart';
import 'WebPage.dart';
import 'HomePage.dart';


import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'images/slide1.jpeg',
  'images/slide2.jpeg',
  'images/slide3.jpeg',
  'images/slide4.jpeg',
  'images/slide5.jpeg',
  'images/slide6.jpeg',
];
final List<String> captionList = [
  'The Bahamas',
  'Hawaii',
  'Fresno State University',
  'Gulf Shores, Alabama',
  'Live fast, Dye young',
  'Yosemite National Park',
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                captionList[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoPageState();
  }
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('DyeIsLife'), automaticallyImplyLeading: false,),
      body: ListView(
        children: <Widget>[
          Image.asset('images/dyeislifetext.png', height: 100),
          Text(
              'Although Dye and Snappa have been around since the early 70s, Dyeislife is the first platform that brings players across the world together',
              textAlign: TextAlign.center),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(children: [
                CarouselWithIndicator(),
              ])),
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('images/tournaments.png', width: 150),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "Tournaments",
                              selectedUrl:
                                  "https://dyeislife.com/pages/tournaments",
                            )));
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('images/apparel.png', width: 150),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyWebView(
                              title: "Apparel",
                              selectedUrl:
                                  "https://dyeislife.com/collections",
                            )));
                  },
                ),
              ]),
          SizedBox(
            height: 25,
          ),
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset('images/rules.png', width: 340),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return new RulesPage();
                      }),
                    );
                  },
                ),
              ]),
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
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
}//update 
