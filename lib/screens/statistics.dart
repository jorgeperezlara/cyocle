import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/EmptyContent.dart';
import 'package:rpm_jack_counter/widgets/statsCard.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();

  StatisticsScreen();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
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
            child: Text('Statistics', style: kTitleStyle),
          ),
          Expanded(
            //para que tome todo el valor de la pantalla que queda, porque se lía si no.
            child: session.listOfStats.length == 0
                ? EmptyContent()
                : ListView.builder(
                    itemCount: session.listOfStats.length,
                    itemBuilder: (context, index) {
                      var newIndex = session.listOfStats.length - 1 - index;
                      var item = session.listOfStats[newIndex];
                      return Dismissible(
                        key: Key(newIndex.toString()),
                        onDismissed: (direction) {
                          setState((){session.removeItemAt(FileName.stat, newIndex);});
                        },
                        child: StatsCard(
                            stat: item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
