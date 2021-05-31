import 'package:flutter/material.dart';
import 'package:khmerjob_project/pages/home_page.dart';
import 'package:khmerjob_project/pages/login_page.dart';

void main() {
  runApp(khmer_job());
}
class khmer_job extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
      // home: HomePage(),
    );
  }
}
