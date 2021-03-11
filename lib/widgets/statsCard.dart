import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/dataClasses/statData.dart';
import 'package:rpm_jack_counter/engine/calculator.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class StatsCard extends StatelessWidget {

  final Statistic stat;
  StatsCard({@required this.stat});

  @override
  Widget build(BuildContext context) {

    int averageRPM = stat.averageRPM;
    int maxRPM = stat.maxRPM;
    DateTime date = stat.date;
    int duration = stat.totalDurationSec;

    return Padding(
      padding: kItemPadding,
      child: Center(
          child: Card(
        shadowColor: kShadowColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: kElevation,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: kStatCardImage,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(30.0)),
          padding: kCardPadding,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${date.day} / ${date.month} / ${date.year}',
                style: kAccentTextStyle.copyWith(color: Colors.white)),
            SizedBox(height: 30),
            Row(
              children: [
                Text('Average RPM',
                    style: kAccentTextStyle.copyWith(color: Colors.white)),
                Text('$averageRPM', style: kLittleDigitStyle.copyWith(color: Colors.white))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
            ),
            Row(
                children: [
                  Text('Max. RPM',
                      style: kAccentTextStyle.copyWith(color: Colors.white)),
                  Text('$maxRPM', style: kLittleDigitStyle.copyWith(color: Colors.white))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,),
            Row(
              children: [
                Text('Time',
                    style: kAccentTextStyle.copyWith(color: Colors.white)),
                Text(Calculations.formatDateFromSecs(duration), style: kLittleDigitStyle.copyWith(color: Colors.white))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
            ),
          ]),
        ),
      )),
    );
  }
}