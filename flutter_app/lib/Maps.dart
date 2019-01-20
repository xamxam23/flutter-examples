import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new MapState();
}

class MapState extends State<MapsWidget> {
    GoogleMapController mapController;

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: AppBar(
                title: const Text("GoogleMap"),
                primary: true,
            ),
            body: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        Center(
                            child: SizedBox(
                                width: double.infinity,
                                height: 480,
                                child: GoogleMap(onMapCreated: _onMapCreated)
                            )
                        ),
                    ],
                )
            )
        );
    }

    void _onMapCreated(GoogleMapController controller) {
        setState(() {
            mapController = controller;
        });
    }
}