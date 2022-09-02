import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locations/share/location_style.dart';

class LocationTextStyle {
  static final baseTextStyle =
      GoogleFonts.getFont('Raleway').copyWith(color: LocationStyle.colorDarkBlue);

  static final regularTextStyle = baseTextStyle.copyWith(
    fontSize: 13,
  );
  static final largeTextStyle = baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static final regularWhiteTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 13,
  );
  static final priceTextStyle = baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final priceWhiteTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final priceGreyTextStyle = priceTextStyle.copyWith(
    color: Colors.grey,
  );
  static final regularGreyTextStyle =
      baseTextStyle.copyWith(color: Colors.grey, fontSize: 13);
  static final boldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
  );
  static final subTitleboldTextStyle =
  baseTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16);
  static final titleboldTextStyle =
  baseTextStyle.copyWith(
    color: Colors.white,fontWeight: FontWeight.bold, fontSize: 21,);
}
