import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {

  final void Function(File image) onSelectPicture;

  const ImageInput({super.key, required this.onSelectPicture});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedPicture;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage =
    await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (takenImage == null) {
      return;
    }

    setState(() {
      _selectedPicture = File(takenImage.path);
    });

    widget.onSelectPicture(_selectedPicture!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture!'),
    );

    if (_selectedPicture != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedPicture!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme
              .of(context)
              .colorScheme
              .primary
              .withOpacity(0.3),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
