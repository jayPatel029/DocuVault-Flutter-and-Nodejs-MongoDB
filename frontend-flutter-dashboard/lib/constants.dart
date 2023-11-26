import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsivedashboard/pages/about_page.dart';
import 'package:responsivedashboard/pages/login_page.dart';
import 'package:responsivedashboard/pages/desktop_body.dart';
import 'package:responsivedashboard/pages/view_docs.dart';

var defaultBackgroundColor = Colors.white;
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      DrawerHeader(
        child: Center(
          child: Text(
            "DocuVault",
            style: GoogleFonts.neuton(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 54,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DesktopScaffold()));
            },
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'D A S H B O A R D',
                style: GoogleFonts.neuton(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      Padding(
        padding: tilePadding,
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ViewDocs()));
            },
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'M Y   D O C S',
                style: GoogleFonts.neuton(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      Builder(builder: (context) {
        return Padding(
          padding: tilePadding,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutPge()));
            },
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                'A B O U T',
                style: GoogleFonts.neuton(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      Padding(
        padding: tilePadding,
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: GoogleFonts.neuton(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    ],
  ),
);
