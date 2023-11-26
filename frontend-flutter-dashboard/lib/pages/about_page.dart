import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/constants.dart';

class AboutPge extends StatefulWidget {
  const AboutPge({super.key});

  @override
  State<AboutPge> createState() => _AboutPgeState();
}

class _AboutPgeState extends State<AboutPge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myDrawer,
          Expanded(
            child: Container(
              color: Colors.transparent,
              width: 600,
              height: 400,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.profile_circled,
                    size: 70,
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
                          color: Colors.grey,
                        ),
                        width: 700,
                        height: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "What do we do?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "1. Secure and Reliable Storage Your documents are your assets, and we treat them as such. Benefit from state-of-the-art security measures to ensure your data is protected at all times. Our reliable storage infrastructure guarantees accessibility whenever you need it.",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
