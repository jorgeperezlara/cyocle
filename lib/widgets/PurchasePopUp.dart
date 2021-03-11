import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/engine/StoreEngine.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class PurchasePopUp extends StatefulWidget {
  @override
  _PurchasePopUpState createState() => _PurchasePopUpState();
  final void Function(DonationType donationType) function;
  PurchasePopUp({this.function});
}

class _PurchasePopUpState extends State<PurchasePopUp> {
  List<DropdownMenuItem<DonationType>> items = [
    DropdownMenuItem<DonationType>(
        child: Text('I liked this app!', style: kSettingsFont),
        value: DonationType.donation099),
    DropdownMenuItem<DonationType>(
        child: Text('I loved this app!', style: kSettingsFont),
        value: DonationType.donation199),
    DropdownMenuItem<DonationType>(
        child: Text('This app has made me happy again!', style: kSettingsFont),
        value: DonationType.donation399)
  ];
  DropdownMenuItem<DonationType> chosenValue;

  DropdownMenuItem<DonationType> getItem (DonationType donationType){
    switch(donationType){
      case DonationType.donation099:
        return items[0];
        break;
      case DonationType.donation199:
        return items[1];
        break;
      case DonationType.donation399:
        return items[2];
        break;
    }
  }

  @override
  void initState() {
    chosenValue = items[0];
    super.initState();
  }

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
            Text('Choose an option', style: kPopUpTitleStyle),
            SizedBox(height: 30),
            DropdownButton(
              icon: Icon(Icons.arrow_drop_down, color: kArrowColor),
              items: items,
              onChanged: (value) {
                chosenValue = getItem(value);
                setState(() {});
              },
              value: chosenValue.value
            ),
            Row(
              children: [
                FlatButton(
                    onPressed: () {
                      widget.function(chosenValue.value);
                      Navigator.pop(context);
                    },
                    child: Text('Purchase', style: kPopUpTextTitleStyle),
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
