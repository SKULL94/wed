import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const plumDeep   = Color(0xFF1F0A1C);
const plum       = Color(0xFF3A1233);
const navyDeep   = Color(0xFF0A1626);
const gold       = Color(0xFFD4AF37);
const goldSoft   = Color(0xFFE8C766);
const goldBright = Color(0xFFF5D780);
const ivory      = Color(0xFFF6ECD9);
const ivoryDim   = Color(0xFFCBB98F);

const bgGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [plumDeep, plum, navyDeep],
  stops: [0, 0.42, 1],
);

TextStyle cinzel({
  double size = 14,
  Color color = ivory,
  FontWeight weight = FontWeight.w500,
  double spacing = 1,
}) =>
    GoogleFonts.cinzel(fontSize: size, color: color, fontWeight: weight, letterSpacing: spacing);

TextStyle cormorant({
  double size = 16,
  Color color = ivory,
  FontStyle style = FontStyle.normal,
  FontWeight weight = FontWeight.w400,
}) =>
    GoogleFonts.cormorantGaramond(fontSize: size, color: color, fontStyle: style, fontWeight: weight);

TextStyle tangerine({double size = 36, Color color = ivory}) =>
    GoogleFonts.tangerine(fontSize: size, color: color, fontWeight: FontWeight.w700);
