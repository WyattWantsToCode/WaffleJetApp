import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance.ref();

Future<String> getImageURL() async {
  String string = await storage.child("worshiping.jpg").getDownloadURL();
  return string;
}
