import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_app/screens/homepage.dart';
import 'package:flutter/widgets.dart';
import 'package:mytodo_app/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        home: Homepage());
  }
}
