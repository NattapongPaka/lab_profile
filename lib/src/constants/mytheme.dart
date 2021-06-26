import 'package:flutter/material.dart';
import 'package:profile/src/utils/index.dart';

class MyTheme {
  static final Color primary = HexColorUtil("#3F51B5");
  static final Color primaryDark = HexColorUtil("#303F9F");
  static final Color primaryLight = HexColorUtil("#C5CAE9");
  static final Color accent = HexColorUtil("#536DFE");
  static final Color primaryText = HexColorUtil("#212121");
  static final Color secondaryText = HexColorUtil("#757575");
  static final Color icons = HexColorUtil("#FFFFFF");
  static final Color divider = HexColorUtil("#BDBDBD");

  static final String weekDayNormal = "#DEC390";
  static final String weekDaySelect = "#F99746";
  static final String weekDayNone = "#BDBDBD";

  static final Color lightGreen = HexColorUtil("#A4EFA9");
  static final Color green = HexColorUtil("#86D88C");
  static final Color orange = HexColorUtil("#E69740");
  static final Color red = HexColorUtil("#F05F5F");

  static var myTheme = ThemeData(
    primaryColor: primary,
    primaryColorDark: primaryDark,
    accentColor: accent,
    primaryColorLight: primaryLight,
    dividerColor: divider,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /**
  <color name="primary">#3F51B5</color>
  <color name="primary_dark">#303F9F</color>
  <color name="primary_light">#C5CAE9</color>
  <color name="accent">#536DFE</color>
  <color name="primary_text">#212121</color>
  <color name="secondary_text">#757575</color>
  <color name="icons">#FFFFFF</color>
  <color name="divider">#BDBDBD</color>
   */
}
