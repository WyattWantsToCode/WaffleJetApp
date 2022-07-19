import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/firebase.dart';

Widget specificEvent(Event event) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Divider(),
        Text(event.title, style: TextStyle(fontSize: 36,)),
        Text(event.description , style: TextStyle(fontSize: 24,))
      ],
    ),
  );
}
