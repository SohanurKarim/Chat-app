import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  // const UserImagePicker({Key? key}) : super(key: key);
  const UserImagePicker(this.imagePickFn);

  final void Function(XFile pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
    XFile? _pickedImage;

  Future _pickImage() async {
    try {
      final XFile? _pickedImage = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 50,
      );

      if (_pickedImage == null) return;

      final file = XFile(_pickedImage.path);
      setState(() => this._pickedImage = file);
      widget.imagePickFn(_pickedImage);
    } on PlatformException catch (e) {
      print('Failed to pick Image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: _pickedImage != null
              ? Image.file(
                  File(_pickedImage!.path),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                )
              : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 45,
                  child: ClipOval(
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                    ),
                  ),
                ),
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
