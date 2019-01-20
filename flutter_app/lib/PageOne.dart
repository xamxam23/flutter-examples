import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(32.0),
            padding: EdgeInsets.all(32.0),
            color: Colors.white,
            child: Image.asset('assets/shoe.png')
        );
    }
}
