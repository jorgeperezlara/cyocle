import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: kItemPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('About', style: kTitleStyle),
            Padding(
              padding: kAboutItemVerticalPadding.copyWith(top: 40),
              child: Text('Made with ❤️ from Madrid with Flutter.',
                  style: kAboutFont),
            ),
            Padding(
              padding: kAboutItemVerticalPadding,
              child: Center(child: Text('Special thanks to:', style: kAboutFont)),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Text('Google and the Flutter dev team', style: kAboutFont),
                  SizedBox(height: 20),
                  Text(
                      'For the amazing flutter framework and for releasing so much cool stuff for free. You guys rock!', style: kThanksFont),
                  SizedBox(height: 20),
                  Text('Freepik.com', style: kAboutFont),
                  SizedBox(height: 20),
                  Text(
                      'For the excellent cat ilustration (seriously, it\'s crazy to believe it was free!).', style: kThanksFont),
                  SizedBox(height: 20),
                  Text('Aaron Alef', style: kAboutFont),
                  SizedBox(height: 20),
                  Text(
                      'For the mic library. Go check his github: github.com/anarchuser', style: kThanksFont),
                  SizedBox(height: 20),
                  Text('dnfield.dev', style: kAboutFont),
                  SizedBox(height: 20),
                  Text(
                      'For the SVG renderer library. It was very simple to use. You can grab it at github.com/dnfield', style: kThanksFont),
                  SizedBox(height: 20),
                  Text(
                      'My brother and my friends Edu and Antonio, who inspired me to pursue a new path in my life.',
                      style: kAboutFont),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Center(
              child: FlatButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  shape: RoundedRectangleBorder(
                    borderRadius: kResetButtonBorder,
                  ),
                  color: kBackButtonColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_rounded, color: kArrowColor,),
                          SizedBox(width: 5,),
                          Text('Go back', style: kAboutFont)
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ))),
            )
          ]),
        ),
      ),
    );
  }
}
