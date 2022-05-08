import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app_animated_ui/screens/home/home_screen.dart';

import 'constants.dart';

void main() {
  var mySystemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.white, systemNavigationBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            shape: const StadiumBorder(),
            backgroundColor: primaryColor,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
