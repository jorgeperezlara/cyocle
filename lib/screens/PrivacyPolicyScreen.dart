import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:markdown/markdown.dart' as MD;

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreen createState() => _PrivacyPolicyScreen();
}

class _PrivacyPolicyScreen extends State<PrivacyPolicyScreen> {
  String privacyHTML = '';

  Future<String> get privacyFile async {
    var privacyFile = await rootBundle.loadString('assets/PrivacyPolicy.md');
    return privacyFile;
  }

  void loadHTML() async {
    var loadFile = await privacyFile;
    privacyHTML = MD.markdownToHtml(loadFile);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loadHTML();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: kItemPadding,
          child: Stack(
            children: [
              ListView(children: [HtmlWidget(privacyHTML)]),
              Positioned.fill(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0, 20.0),
                    child: FlatButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: kResetButtonBorder,
                        ),
                        color: kBackButtonColor,
                        child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  color: kArrowColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Go back', style: kAboutFont)
                              ],
                              mainAxisSize: MainAxisSize.min,
                            ))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
