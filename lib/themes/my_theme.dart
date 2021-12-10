

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme{

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    canvasColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,


  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    canvasColor: Colors.black,
    fontFamily: GoogleFonts.poppins().fontFamily,


  );



}