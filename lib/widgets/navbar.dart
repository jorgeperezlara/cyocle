import 'package:flutter/material.dart';
import 'package:rpm_jack_counter/engine/DarkMode.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/outernotch.dart';

class FABBottomAppBarItem {
  final String label;
  final IconData icon;
  FABBottomAppBarItem({@required this.label, @required this.icon});
}

class FABNavBar extends StatefulWidget {
  final bool isPlaying;
  final List<FABBottomAppBarItem> items;
  final void Function(int) returnIndex;
  final bool darkON;
  final void Function() controllerFun;
  FABNavBar(
      {this.items,
      this.returnIndex,
      this.isPlaying,
      this.darkON,
      this.controllerFun});

  @override
  _FABNavBarState createState() => _FABNavBarState();
}

class _FABNavBarState extends State<FABNavBar> {
  int _selectedIndex = 0;

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
      widget.controllerFun();
    });
    this.widget.returnIndex(index);
  }

  Widget buildSideItem(
      FABBottomAppBarItem item, int index, void Function(int) indexPressed) {
    bool isSelected = _selectedIndex == index ? true : false;
    Color iconColor = isSelected ? Colors.grey[800] : Colors.grey;

    return InkWell(
      onTap: () {
        indexPressed(index);
      },
      child: Padding(
        padding: kBottomAppBarPadding,
        child: Column(
          children: [
            Icon(item.icon, color: iconColor, size: kIconSize),
            Text(item.label, style: kBotBar.copyWith(color: iconColor)),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DarkMode.toggleDark(widget.darkON);
    List<Widget> itemList = [];
    for (int i = 0; i < this.widget.items.length; i++) {
      itemList.add(buildSideItem(this.widget.items[i], i, setIndex));
      if (i == this.widget.items.length / 2 - 1) {
        itemList.add(SizedBox(
          width: 20,
        ));
      }
    }
    return Material(
      elevation: 20,
      shadowColor: Colors.black,
      child: BottomAppBar(
        color: kBackgroundColor,
        elevation: 0,
        child: Row(
          children: itemList,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
