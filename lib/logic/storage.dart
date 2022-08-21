import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

final storage = FirebaseStorage.instance.ref();

Future<String> getImageURL(Event event) async {
  String string = await storage.child(event.id).getDownloadURL();
  return "https://drive.google.com/uc?export=view&id=10G_htCy4i8A5iApwDtWWWrVCh4SJ8bdb";

  
}

Future<String> getLogoURL() async {
  String url = await storage.child("AppSetup/logo.png").getDownloadURL();
  return "https://drive.google.com/uc?export=view&id=10G_htCy4i8A5iApwDtWWWrVCh4SJ8bdb";
}


