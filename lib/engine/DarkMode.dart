import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DarkMode {
  static Future<void> writeDarkSetting(bool darkON) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkON', darkON);
  }

  static void toggleDark(bool darkON) {
    writeDarkSetting(darkON);
    if (darkON) {
      kBackgroundColor = Colors.grey[900];
      kActiveColor = Colors.amberAccent;
      kLightActiveColor = Color(0xff474139);
      kInactiveColor = Colors.grey[800];
      kTitleStyle = GoogleFonts.barlow(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);
      kBodyTextStyle = GoogleFonts.barlow(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
      kAccentTextStyle = GoogleFonts.barlow(
          fontSize: 25, color: Colors.amber[200], fontWeight: FontWeight.bold);
      kDigitDisplayStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 120,
          fontStyle: FontStyle.italic,
          color: Colors.white);
      kLittleDigitDisplayStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 50,
          fontStyle: FontStyle.italic,
          color: Colors.white);
      kLittleDigitStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 50,
          fontStyle: FontStyle.italic,
          color: Colors.white);
      kShadowColor = Colors.amber[800];
      kBotBar = GoogleFonts.barlow(fontSize: 12, color: Colors.white);
      kSettingsFont = GoogleFonts.barlow(fontSize: 18, color: Colors.white);
      kPopUpTitleStyle = GoogleFonts.barlow(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
      kPopUpTextTitleStyle =
          GoogleFonts.barlow(fontSize: 15, color: Colors.white);
      kHintTextStyle = GoogleFonts.barlow(fontSize: 20, color: Colors.white);
      kEmptySpaceText = GoogleFonts.barlow(fontSize: 20, color: Colors.white70);
      kDialogFont = GoogleFonts.barlow(color: Colors.white);
      kToggleColor = Colors.amberAccent;
      kBorderColor = Colors.grey[700];

      kRpmImage = AssetImage('assets/images/home_night.png');
      kWeightImage = AssetImage('assets/images/weight_night.png');
      kStatCardImage = AssetImage('assets/images/rpm_night.png');

      kBackButtonColor = Colors.grey[800];
      kAboutFont = GoogleFonts.barlow(fontSize: 18, color: Colors.white);
      kThanksFont = GoogleFonts.barlow(fontSize: 14, color: Colors.grey);
      kAboutItemVerticalPadding = EdgeInsets.symmetric(vertical: 15);
      kArrowColor = Colors.white;
    } else {
      kActiveColor = Colors.pinkAccent;
      kBackgroundColor = Colors.white;
      kLightActiveColor = Colors.pink[50];
      kInactiveColor = Colors.grey[300];
      kTitleStyle =
          GoogleFonts.barlow(fontSize: 40, fontWeight: FontWeight.bold);
      kBodyTextStyle = GoogleFonts.barlow(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
      kAccentTextStyle = GoogleFonts.barlow(
          fontSize: 25, color: Colors.pink[200], fontWeight: FontWeight.bold);
      kDigitDisplayStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 120,
          fontStyle: FontStyle.italic,
          color: Colors.white);
      kLittleDigitDisplayStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 50,
          fontStyle: FontStyle.italic,
          color: Colors.white);
      kLittleDigitStyle = TextStyle(
          fontFamily: 'DS Digital',
          fontSize: 50,
          fontStyle: FontStyle.italic,
          color: Colors.black);
      kShadowColor = Colors.pink[200];
      kBotBar = GoogleFonts.barlow(fontSize: 12);
      kSettingsFont = GoogleFonts.barlow(fontSize: 18);
      kPopUpTitleStyle = GoogleFonts.barlow(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
      kPopUpTextTitleStyle =
          GoogleFonts.barlow(fontSize: 15, color: Colors.white);
      kHintTextStyle = GoogleFonts.barlow(fontSize: 20);
      kEmptySpaceText = GoogleFonts.barlow(fontSize: 20, color: Colors.grey);
      kDialogFont = GoogleFonts.barlow();
      kToggleColor = Colors.pink[200];
      kBorderColor = Colors.grey[300];

      kRpmImage = AssetImage('assets/images/home_day.jpg');
      kWeightImage = AssetImage('assets/images/weight_day.png');
      kStatCardImage = AssetImage('assets/images/rpm_day.png');

      kBackButtonColor = Colors.grey[200];
      kAboutFont = GoogleFonts.barlow(fontSize: 18, color: Colors.black);
      kThanksFont = GoogleFonts.barlow(fontSize: 14, color: Colors.grey);
      kAboutItemVerticalPadding = EdgeInsets.symmetric(vertical: 15);
      kArrowColor = Colors.black;
    }
  }
}
