import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

final storage = FirebaseStorage.instance.ref();

Future<String> getImageURL(Event event) async {
  String string = await storage.child(event.id).getDownloadURL();
  return string;

  
}

Future<String> getLogoURL() async {
  String url = await storage.child("AppSetup/logo.png").getDownloadURL();
  return url;
}


