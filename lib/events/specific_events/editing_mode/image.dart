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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImageURL(widget.event),
        builder: ((context, snapshot) {
          DecorationImage decorationImage = DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(snapshot.data.toString()));
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
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:
                            getColorFromList(appSetup.colorMap["colorSecond"])),
                    onPressed: () {
                      replaceImageInStorage(widget.event.id).then(
                        (value) {
                          setState(() {});
                        },
                      );
                    },
                    child: Text(
                      "Change Photo",
                      style: styleSubtitle.apply(
                          color: getColorFromList(
                              appSetup.colorMap["colorFourth"])),
                    )),
              ),
            ],
          );
        }));
  }
}
