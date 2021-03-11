import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/images/kitty.svg', height: 200, width: 200),
        SizedBox(height: 30, width: double.infinity,),
        Text('Nothing to show...', style: kEmptySpaceText),
        SizedBox(height: 10),
        Text('(so far)', style: kEmptySpaceText.copyWith(fontSize: 14))
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
