import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joelfindtechnician/widgets/show_image.dart';


class AddReferance extends StatefulWidget {
  const AddReferance({ Key? key }) : super(key: key);

  @override
  _AddReferanceState createState() => _AddReferanceState();
}

class _AddReferanceState extends State<AddReferance> {

  File? imageFile;
  List<File?> files = [];

  @override
  void initState() { 
    super.initState();
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  Future<Null> chooseSourceImage(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        imageFile = File(result!.path);
        files[index] = imageFile;
      });
    } catch (e) {}
  }


  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          Container(
              width: 250,
              child: imageFile == null ? ShowImage() : Image.file(imageFile!)),
          SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              files[0] == null
                  ? IconButton(
                      onPressed: () =>
                          chooseSourceImage(ImageSource.gallery, 0),
                      icon: Icon(Icons.filter_1),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onLongPress: () =>
                            chooseSourceImage(ImageSource.gallery, 0),
                        onTap: () {
                          setState(() {
                            imageFile = files[0];
                          });
                        },
                        child: Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              files[1] == null
                  ? IconButton(
                      onPressed: () =>
                          chooseSourceImage(ImageSource.gallery, 1),
                      icon: Icon(Icons.filter_2),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onLongPress: () =>
                            chooseSourceImage(ImageSource.gallery, 1),
                        onTap: () {
                          setState(() {
                            imageFile = files[1];
                          });
                        },
                        child: Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              files[2] == null
                  ? IconButton(
                      onPressed: () =>
                          chooseSourceImage(ImageSource.gallery, 2),
                      icon: Icon(Icons.filter_3),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onLongPress: () =>
                            chooseSourceImage(ImageSource.gallery, 2),
                        onTap: () {
                          setState(() {
                            imageFile = files[2];
                          });
                        },
                        child: Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              files[3] == null
                  ? IconButton(
                      onPressed: () =>
                          chooseSourceImage(ImageSource.gallery, 3),
                      icon: Icon(Icons.filter_4),
                    )
                  : Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onLongPress: () =>
                            chooseSourceImage(ImageSource.gallery, 3),
                        onTap: () {
                          setState(() {
                            imageFile = files[3];
                          });
                        },
                        child: Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildImage(),
    );
  }
}