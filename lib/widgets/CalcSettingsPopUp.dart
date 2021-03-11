import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class CalcSettingsPopUp extends StatefulWidget {
  @override
  _CalcSettingsPopUpState createState() => _CalcSettingsPopUpState();
  final void Function() function;
  CalcSettingsPopUp({this.function});
}

class _CalcSettingsPopUpState extends State<CalcSettingsPopUp> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SavingSession>(context, listen: false);
    TextEditingController txt = TextEditingController();
    txt.text = session.filterValue.toString();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: kBackgroundColor),
      child: Padding(
        padding: kCardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Adjust engine sensitivity', style: kPopUpTitleStyle),
            SizedBox(height: 30),
            CheckboxListTile(
              title: Text('Catch only odd pulses', style: kSettingsFont,),
                activeColor: kActiveColor,
                value: session.oddOnly,
                onChanged: (value) {
                  session.oddOnly = value;
                  setState(() {});
                }),
            Container(
                child: TextField(
                  style: kHintTextStyle,
                  controller: txt,
                    decoration: InputDecoration(
                        hintText: 'Input new intensity value (default: 1.5)...',
                        hintStyle: kHintTextStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      session.filterValue = double.parse(value);
                    }),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kLightActiveColor)),
            SizedBox(height: 30),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      widget.function();
                      Navigator.pop(context);
                    },
                    child: Text('Set', style: kPopUpTextTitleStyle),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: kActiveColor),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: kPopUpTextTitleStyle),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: kInactiveColor),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ),
    );
  }
}
