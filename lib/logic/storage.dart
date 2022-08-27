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

Future<String> selectPicture(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(source: source);
  return image?.path as String;
}

void uploadToStorage(String id) async {
  String path = await selectPicture(ImageSource.gallery);

  if (path.isNotEmpty) {
    Uint8List imageData = await XFile(path).readAsBytes();
    storage.child(id).putData(imageData);
  }
}

Future<void> replaceImageInStorage(String id) async {
  String path = await selectPicture(ImageSource.gallery);

  if (path.isNotEmpty) {
    Uint8List imageData = await XFile(path).readAsBytes();
    storage.child(id).delete();
    storage.child(id).putData(imageData);
  }
}
