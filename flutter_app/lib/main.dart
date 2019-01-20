import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Maps.dart';
import 'package:flutter_app/PageOne.dart';
import 'package:flutter_app/PhotoView.dart';
import 'package:flutter_app/ToolsWidget.dart';

void main() => runApp(MyApp());
MaterialColor themeColor = Colors.green;

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Startup Name Generator',
            theme: new ThemeData(
                primaryColor: themeColor
            ),
            home: RandomWords(),
        );
    }
}

class RandomWords extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new RandomWordsState();
}

class Choice {
    const Choice({this.title, this.icon});

    final String title;
    final IconData icon;
}

const List<Choice> choices = const <Choice>[
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.directions_bike),
    const Choice(title: 'Boat', icon: Icons.directions_boat),
    const Choice(title: 'Bus', icon: Icons.directions_bus),
    const Choice(title: 'Train', icon: Icons.directions_railway),
    const Choice(title: 'Walk', icon: Icons.directions_walk),
];

class RandomWordsState extends State<RandomWords> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    int currentTab = 0;
    Widget home;
    Widget photo;
    Widget one;
    Widget map;
    Widget settings;
    Widget tools;
    List<Widget> pages;
    Widget currentPage;
    final _suggestions = <WordPair>[];
    final _saved = new Set<WordPair>();
    final _biggerFont = const TextStyle(fontSize: 18.0);

    @override void initState() {
        currentPage = home = _buildSuggestions();
        tools = new ToolsWidget();
        photo = new CameraWidget();
        one = PageOne();
        map = new MapsWidget();
        pages = [home, photo, one, map, tools];
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: new Drawer(
                child: new ListView(
                    children: <Widget>[
                        new UserAccountsDrawerHeader(
                            accountName: Text("Maxime Mbabele"),
                            accountEmail: Text("maxime.mbabele@gmail.com"),
                            currentAccountPicture: new CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text("MM"),
                            ),
                        ),
                        new ListTile(
                            title: Text("Home"),
                            leading: Icon(Icons.home),
                            onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                    currentPage = pages[currentTab = 0];
                                });
                            },
                        ),
                        new ListTile(
                            title: Text("Map"),
                            leading: Icon(Icons.map),
                            onTap: () => Navigator.of(context).pop(),
                        ),
                        Divider(),
                    ],
                )
            ),
            key: _scaffoldKey,
            appBar: AppBar(
                title: Text('Home'),
                actions: <Widget>[
                    new IconButton(icon: const Icon(Icons.favorite_border),
                        onPressed: _pushSaved),
                    new IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: 'SnackBar',
                        onPressed: () {
                            SnackBar snackbar = SnackBar(
                                content: Text("Sending Message"));
                            print("<> show snack bar");
                            _snack("Hello snack");
                            //Scaffold.of(context).showSnackBar(snackbar);
                        }),
                    // overflow menu
                    PopupMenuButton<Choice>(
                        onSelected: _select,
                        itemBuilder: (BuildContext context) {
                            return choices.skip(2).map((Choice choice) {
                                return PopupMenuItem<Choice>(
                                    value: choice,
                                    child: Text(choice.title),
                                );
                            }).toList();
                        },
                    ),
                ]
            ),
            body: currentTab == 0 ? _buildSuggestions() : pages[currentTab],
            bottomNavigationBar: new BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: currentTab,
                onTap: (int index) {
                    setState(() {
                        currentTab = index;
                        currentPage = pages[index];
                    });
                },
                items: [ createItem(Icons.home, "Home"),
                createItem(Icons.photo_camera, "Camera"),
                createItem(Icons.build, "Tools"),
                createItem(Icons.location_searching, "Map"),
                createItem(Icons.settings, "Settings"),
                ]
            ),
        );
    }

    BottomNavigationBarItem createItem(IconData iconData, String title) {
        return new BottomNavigationBarItem(
            backgroundColor: themeColor,
            icon: Icon(iconData), title: Text(title));
    }

    void _snack(String string) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(string)));
    }

    void _pushSaved() {
        Navigator.of(context).push(
            new MaterialPageRoute<void>(
                builder: (BuildContext context) {
                    final Iterable<ListTile> tiles = _saved.map(
                            (WordPair pair) {
                            return new ListTile(
                                title: new Text(
                                    pair.asPascalCase,
                                    style: _biggerFont,
                                )
                            );
                        }
                    );

                    final List<Widget> divided = ListTile
                        .divideTiles(
                        context: context,
                        tiles: tiles,
                    ).toList();

                    return new Scaffold(
                        appBar: new AppBar(
                            title: const Text('Saved Suggestions'),
                        ),
                        body: new ListView(children: divided),
                    );
                }
            ),
        );
    }

    Widget _buildSuggestions() {
        return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, i) {
                if (i.isOdd) return Divider();
                /*2*/
                final index = i ~/ 2; /*3*/
                if (index >= _suggestions.length) {
                    _suggestions.addAll((generateWordPairs().take(10))); /*4*/
                }
                return _buildRow(_suggestions[index]);
            }
        );
    }

    Widget _buildRow(WordPair pair) {
        final bool alreadySaved = _saved.contains(pair);
        return ListTile(
            title: Text(
                pair.asPascalCase,
                style: _biggerFont,
            ),
            trailing: new Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
            ),
            onTap: () {
                setState(() {
                    if (alreadySaved) {
                        _saved.remove(pair);
                    } else {
                        _saved.add(pair);
                    }
                });
            },
        );
    }

    void _select(Choice value) {
        print(value);
    }
}