import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => new CameraState();
}

class CameraState extends State<CameraWidget> {
    File _image;

    Future getImage() async {
        var image = await ImagePicker.pickImage(source: ImageSource.camera);
        setState(() {
            _image = image;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("Camera")
            ),
            body: new Center(
                child:
                _image == null ? Text("No image selected") : Image.file(_image),
            ),
            floatingActionButton:
            new FloatingActionButton(onPressed: getImage,
                tooltip: 'Pick Image',
                child: new Icon(Icons.camera),
            ),
        );
    }
}