import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/engine/calculator.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/rpm_monitor.dart';

class HomePage extends StatefulWidget {
  final int rpm;
  final int maxRPM;
  final int averageRPM;
  final int durationInSeconds;
  HomePage(
      {Key key, this.rpm, this.maxRPM, this.averageRPM, this.durationInSeconds})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: kItemPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Home', style: kTitleStyle),
            RPMCard(rpm: widget.rpm),
            Row(
              children: [
                Text('Average RPM', style: kAccentTextStyle),
                Text(widget.averageRPM.toString(), style: kLittleDigitStyle)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
            ),
            Row(
                children: [
                  Text('Max. RPM', style: kAccentTextStyle),
                  Text(widget.maxRPM.toString(), style: kLittleDigitStyle)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic),
            Row(
                children: [
                  Text('Time', style: kAccentTextStyle),
                  Text(
                      Calculations.formatDateFromSecs(
                          widget.durationInSeconds),
                      style: kLittleDigitStyle)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic),
            Material(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
