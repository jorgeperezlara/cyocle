import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class PlaySaveFAB extends StatelessWidget {
  const PlaySaveFAB(
      {Key key, @required bool isPlaying, @required void Function() onPressed})
      : _isPlaying = isPlaying,
        _onPressed = onPressed,
        super(key: key);

  final bool _isPlaying;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: kActiveColor,
      elevation: 3,
      shape: CircleBorder(),
      child: FloatingActionButton(
          child: Icon(
            _isPlaying ? Icons.save_alt_rounded : Icons.play_arrow,
            size: kIconSize,
          ),
          backgroundColor: kActiveColor,
          elevation: 0,
          onPressed: _onPressed),
    );
  }
}

class AddWeightFAB extends StatelessWidget {
  const AddWeightFAB({Key key, @required void Function() onPressed})
      : _onPressed = onPressed,
        super(key: key);

  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
        shadowColor: kActiveColor,
        elevation: 3,
        shape: CircleBorder(),
        child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: kIconSize,
            ),
            backgroundColor: kActiveColor,
            elevation: 0,
            onPressed: _onPressed));
  }
}
