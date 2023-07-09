import 'dart:io';

import 'package:chat_app/elements/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage(this.onImagePicked, {super.key});

  final void Function(File imageFilePicked) onImagePicked;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          child: _pickedImage == null
              ? const Icon(
                  Icons.image,
                  color: Colors.white,
                )
              : null,
        ),
        TextButton.icon(
            onPressed: pickImageFromGallery,
            icon: const Icon(
              Icons.edit,
              size: 18,
            ),
            label: const Text("Add Image"))
      ],
    );
  }

  void pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80, maxHeight: 512, maxWidth: 512, requestFullMetadata: false,);

    if (image == null) {
      showSnackBarMessage(
          context, "No image was selected from gallery", Colors.black);
      return;
    }

    setState(() {
      _pickedImage = File(image.path);
    });

    widget.onImagePicked(_pickedImage!);
  }
}
