import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/helps.dart';

class ScreenBusinessAppUpdate extends StatefulWidget {
  final String name;
  final String email;
  final String photo;

  const ScreenBusinessAppUpdate({Key key, this.name, this.email, this.photo})
      : super(key: key);
  @override
  State<ScreenBusinessAppUpdate> createState() =>
      _ScreenBusinessAppUpdateState();
}

class _ScreenBusinessAppUpdateState extends State<ScreenBusinessAppUpdate> {
  File selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  String dropdownvalue = 'Item 1';
  var items = [
    'Per Night',
    'Per Week',
    'Per Month',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Select Category",
          style: appbar,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_outline,
              color: colors,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                      backgroundImage: NetworkImage(
                          '${selectedImage != null ? Image.file(
                              selectedImage,
                              fit: BoxFit.fill,
                              height:
                                  MediaQuery.of(context).size.height / 4.2,
                              width:
                                  MediaQuery.of(context).size.width / 1.5,
                            ) : Image.network(
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                              fit: BoxFit.fill,
                            )}')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colors,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23))),
                    onPressed: () {
                      _choiseShowDialog(context);
                    },
                    child: Text(" Select Image From"),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                        hintStyle: textfield,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "location",
                        hintStyle: textfield,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(264, 40),
                        backgroundColor: colors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    onPressed: () async {},
                    child: Text(
                      "update",
                      style: button,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _choiseShowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Image From"),
            actions: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  chooseImage("Gallery");
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  child: Text("camera"),
                  onTap: () {
                    chooseImage("camera");
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }
}
