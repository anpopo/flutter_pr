import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? image) onPickImage;

  const UserImagePicker({super.key, required this.onPickImage});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final _pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 50);

    if (_pickedImage == null) {
      widget.onPickImage(_pickedImageFile);
      return;
    }

    setState(() {
      _pickedImageFile = File(_pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.withOpacity(0.7),
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image_outlined),
          label: Text(
            _pickedImageFile == null ? 'Add Image' : 'Change Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ),
        )
      ],
    );
  }
}
