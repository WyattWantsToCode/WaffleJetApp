import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/firebase.dart';

class SpecificEventScreen extends StatelessWidget {
  Event event;
  SpecificEventScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text(event.title)]),);
  }
}