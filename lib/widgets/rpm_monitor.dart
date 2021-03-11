import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class RPMCard extends StatelessWidget {
  final int rpm;
  RPMCard({this.rpm});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: kShadowColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        elevation: 20.0,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: kRpmImage,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(30.0)),
          padding: kCardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RPM MONITOR', style: kAccentTextStyle.copyWith(color: Colors.white)),
              SizedBox(height: 30),
              Row(
                  children: [
                    Text('$rpm', style: kDigitDisplayStyle),
                    Text('RPM', style: kLittleDigitDisplayStyle)
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,),
              SizedBox(height: 30),
              Center(
                child: Text('Revolutions per minute', style: kBodyTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}