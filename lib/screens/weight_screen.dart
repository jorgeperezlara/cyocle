import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/engine/calculator.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/EmptyContent.dart';
import 'package:rpm_jack_counter/widgets/weight_card.dart';

class WeightScreen extends StatefulWidget {
  @override
  _WeightScreenState createState() => _WeightScreenState();

}

class _WeightScreenState extends State<WeightScreen> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SavingSession>(context, listen: false);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: kItemPadding,
            child: Text('Weight Records', style: kTitleStyle),
          ),
          Expanded(
            //para que tome todo el valor de la pantalla que queda, porque se lía si no.
            child: session.listOfWeights.length == 0 ? EmptyContent() : ListView.builder(
              itemCount: session.listOfWeights.length,
              itemBuilder: (context, index) {
                var newIndex = session.listOfWeights.length - 1 - index;
                      var item = session.listOfWeights[newIndex];
                      return Dismissible(
                        key: Key(newIndex.toString()),
                        onDismissed: (direction) {
                          setState((){session.removeItemAt(FileName.weight, newIndex);});
                        },
                        child: WeightCard(weight: item, variation: Calculations.calculateVariation(session.listOfWeights, newIndex))
                      );
                  },
            ),
          ),
        ],
      ),
    );
  }
}
