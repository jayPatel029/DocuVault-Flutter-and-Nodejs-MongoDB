import 'package:flutter/material.dart';
import 'package:responsivedashboard/pages/about_page.dart';
import 'package:responsivedashboard/pages/login_page.dart';
import 'package:responsivedashboard/pages/desktop_body.dart';
import 'package:responsivedashboard/pages/view_docs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home:
          // LoginPage(),
          // ViewDocs(),
      // AboutPge(),
          DesktopScaffold(),
    );
  }
}
