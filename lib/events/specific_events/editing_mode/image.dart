import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';
import 'package:qc_collegeandcareer/logic/storage.dart';

class ImageEditing extends StatefulWidget {
  Event event;
  DecorationImage image;
  ImageEditing({Key? key, required this.event, required this.image})
      : super(key: key);

  @override
  State<ImageEditing> createState() => _ImageEditingState();
}

class _ImageEditingState extends State<ImageEditing> {
  TextEditingController controllerURL = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.event.imageURL);
    return FutureBuilder(
      future: getImageURL(widget.event),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            DecorationImage decorationImage = DecorationImage(
                image: NetworkImage(
                  snapshot.data as String,
                ),
                fit: BoxFit.cover);
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * .6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: decorationImage,
                    color: getColorFromList(appSetup.colorMap["colorThird"]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: styleBody,
                    controller: controllerURL,
                    decoration: InputDecoration(
                        labelText: "URL", labelStyle: styleBody),
                    onEditingComplete: (() {
                      widget.event.imageURL =
                          driveURLToImageID(controllerURL.text);
                      controllerURL.clear();
                      setState(() {
                        
                      });
                    }),
                  ),
                ),
                Text(
                  "Image ID:  ${widget.event.imageURL}",
                  style: styleBody.apply(fontSizeDelta: -3),
                ),
                Text(
                  "Change Photo",
                  style: styleSubtitle.apply(
                      color: getColorFromList(
                          appSetup.colorMap["colorFourth"])),
                ),
              ],
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
