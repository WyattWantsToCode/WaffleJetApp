import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';

import 'package:qc_collegeandcareer/events/event_gridview.dart';

import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

import 'package:qc_collegeandcareer/specific_post/specific_event_screen.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        GradientBackground(color: colorAccentSecond),
        Scaffold(


          backgroundColor: colorThird.withOpacity(.3),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Column(children: [
                      
                  
                      homeScreenSectionBuilder(context, "Contacts"),
                      
                    ]),
                  ),
                ),
              ),
             BottomBar(),
            ]),
          ),
        ),
      ],
    );
  }
}


