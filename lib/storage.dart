import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qc_collegeandcareer/firebase.dart';

final storage = FirebaseStorage.instance.ref();

Future<String> getImageURL(Event event) async {
  String string = await storage.child("1d3b94d0-079c-11ed-9580-8145ce3ac963").getDownloadURL();
  return string;
}

/*Future<String> selectPicture(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(source: source);
  return image?.path as String;
}

void uploadToStorage(String id) async {
  String path = await selectPicture(ImageSource.gallery);
  Uint8List imageData = await XFile(path).readAsBytes();
  storage.child(id).putData(
    
    imageData
    
    );
}
*/
