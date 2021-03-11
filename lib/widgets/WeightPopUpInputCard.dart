import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class InputPopUpCard extends StatefulWidget {
  @override
  _InputPopUpCardState createState() => _InputPopUpCardState();
  final void Function(double) function;
  InputPopUpCard({this.function});
}

class _InputPopUpCardState extends State<InputPopUpCard> {
  double weight = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: kBackgroundColor),
      child: Padding(
        padding: kCardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('New weight recording', style: kPopUpTitleStyle),
            SizedBox(height: 30),
            Container(
                child: TextField(
                    style: kHintTextStyle,
                    decoration: InputDecoration(
                        hintText: 'Input new weight (i.e. 75.2)...',
                        hintStyle: kHintTextStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      weight = double.parse(value);
                      print(weight);
                    }),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kLightActiveColor)),
            SizedBox(height: 30),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      widget.function(weight);
                      Navigator.pop(context);
                    },
                    child: Text('Add', style: kPopUpTextTitleStyle),
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