import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput({Key key, this.onSelectImage});
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  PickedFile _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final selectedFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 500);
    setState(() {
      _storedImage = selectedFile;
    });

    if (selectedFile == null) {
      return;
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(selectedFile.path);
    final savedImage =
        await File(selectedFile.path).copy('${appDir.path}/$filename');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.grey,
          ),
          child: _storedImage != null
              ? Image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  image: FileImage(
                    File(_storedImage.path),
                  ))
              : Text(
                  "No image selected",
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: FittedBox(
          child: FlatButton.icon(
            onPressed: () {
              _takePicture();
            },
            icon: Icon(Icons.camera_alt_outlined),
            label: Text("Take a Picture"),
          ),
        )),
      ],
    );
  }
}
