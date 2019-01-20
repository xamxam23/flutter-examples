import 'package:flutter/material.dart';

class ToolsWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new ToolsState();
}

class ToolsState extends State<ToolsWidget> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Layout")
            ),
            body: Center(
                child: buildGrid(),
            ),
        );
    }
}

Widget buildGrid(){
    return new GridView.count(
        //Create a grid with 2 columns. If you change the scrollDirection to
        //horizontal, this would produce 2 rows.
        crossAxisCount: 4,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTileList(32));
}

List<Container> _buildGridTileList(int count){
    return List<Container>.generate(count, (int index) => Container(child: Image.asset('assets/shoe.png')));
}
