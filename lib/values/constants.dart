import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kActiveColor = Colors.pinkAccent;
Color kBackgroundColor = Colors.white;
Color kLightActiveColor = Colors.pink[50];
Color kInactiveColor = Colors.grey[300];
var kTitleStyle = GoogleFonts.barlow(fontSize: 40, fontWeight: FontWeight.bold);
var kBodyTextStyle = GoogleFonts.barlow(
    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
var kAccentTextStyle = GoogleFonts.barlow(
    fontSize: 25, color: Colors.pink[200], fontWeight: FontWeight.bold);
var kDigitDisplayStyle = TextStyle(
    fontFamily: 'DS Digital',
    fontSize: 120,
    fontStyle: FontStyle.italic,
    color: Colors.white);
var kLittleDigitDisplayStyle = TextStyle(
    fontFamily: 'DS Digital',
    fontSize: 50,
    fontStyle: FontStyle.italic,
    color: Colors.white);
var kLittleDigitStyle = TextStyle(
    fontFamily: 'DS Digital',
    fontSize: 50,
    fontStyle: FontStyle.italic,
    color: Colors.black);
Color kShadowColor = Colors.pink[200];
var kCardPadding = EdgeInsets.symmetric(horizontal: 25, vertical: 40);
var kAppPadding = EdgeInsets.all(30);
var kItemPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 20);
var kBotBar = GoogleFonts.barlow(fontSize: 12);
var kIconSize = 35.0;
var kPlayIcon = Icon(Icons.play_arrow, color: Colors.white, size: 40);
var kBottomAppBarPadding = EdgeInsets.all(8.0);
var kResetButtonBorder = BorderRadius.circular(20);
var kSettingsPadding = EdgeInsets.symmetric(vertical: 10);
var kSettingsFont = GoogleFonts.barlow(fontSize: 18);
double kElevation = 20;
enum FileName { stat, weight }
var kPopUpTitleStyle = GoogleFonts.barlow(
    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
var kPopUpTextTitleStyle =
    GoogleFonts.barlow(fontSize: 15, color: Colors.white);
var kHintTextStyle = GoogleFonts.barlow(fontSize: 20);
var kEmptySpaceText = GoogleFonts.barlow(fontSize: 20, color: Colors.grey);
var kDialogFont = GoogleFonts.barlow();
Color kToggleColor = Colors.pink[200];
Color kBorderColor = Colors.grey[300];

var kRpmImage = AssetImage('assets/images/home_day.jpg');
var kWeightImage = AssetImage('assets/images/weight_day.png');
var kStatCardImage = AssetImage('assets/images/rpm_day.png');

Color kBackButtonColor = Colors.grey[200];
TextStyle kAboutFont = GoogleFonts.barlow(fontSize: 18, color: Colors.black);
TextStyle kThanksFont = GoogleFonts.barlow(fontSize: 14, color: Colors.grey);
EdgeInsets kAboutItemVerticalPadding = EdgeInsets.symmetric(vertical: 15);
Color kArrowColor = Colors.black;