import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import for File

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({super.key, required this.onPick});

  final void Function(File pickedFile) onPick;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _image; // Variable to hold the selected image

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final String? source = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'camera'),
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'gallery'),
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(
        source: source == 'camera' ? ImageSource.camera : ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Store the selected image
        });

        widget.onPick(_image!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,

          backgroundColor: Colors.white,
          backgroundImage: _image != null
              ? FileImage(_image!)
              : null, // Display the selected image
          child: _image == null // Show the button only if no image is selected
              ? IconButton(
                  onPressed: _pickImage, // Call the image picker
                  icon: const Icon(Icons.image),
                  // key:
                )
              : null, // No button if an image is selected
        ),
        const SizedBox(height: 10),
        _image != null
            ? // Show a message if an image is selected
            const Text(
                "Image selected!",
                style: TextStyle(color: Colors.white),
              )
            : const Text(
                "Add Image",
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }
}
