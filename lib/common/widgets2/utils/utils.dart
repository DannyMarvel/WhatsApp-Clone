import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

//Now we write a function to pickImage from Gallery
Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
//we first get an instance of PickImage
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      //Then we reasign image
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}


//Now we create a function to PickVideo from Gallery
Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}
