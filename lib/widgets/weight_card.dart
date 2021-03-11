import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/dataClasses/weight_data.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class WeightCard extends StatelessWidget {

  final WeightData weight;
  final String variation;
  WeightCard({this.weight, this.variation});

  @override
  Widget build(BuildContext context) {
    double kg = weight.kg;
    DateTime date = weight.date;

    return Padding(
      padding: kItemPadding,
      child: Center(
          child: Card(
        shadowColor: kShadowColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: kElevation,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: kWeightImage,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(30.0)),
          padding: kCardPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${date.day} / ${date.month} / ${date.year}',
                style: kAccentTextStyle.copyWith(color: Colors.white)),
            SizedBox(height: 30),
            Row(
              children: [
                Text('Weight (kg)',
                    style: kAccentTextStyle.copyWith(color: Colors.white)),
                Text('$kg', style: kLittleDigitStyle.copyWith(color: Colors.white))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
            ),
            Row(
              children: [
                Text('Weight var. (%)',
                    style: kAccentTextStyle.copyWith(color: Colors.white)),
                Text('$variation', style: kLittleDigitStyle.copyWith(color: Colors.white))
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
