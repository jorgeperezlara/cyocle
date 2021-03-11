import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/engine/DarkMode.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/engine/StoreEngine.dart';
import 'package:rpm_jack_counter/screens/AboutScreen.dart';
import 'package:rpm_jack_counter/screens/PrivacyPolicyScreen.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/CalcSettingsPopUp.dart';
import 'package:rpm_jack_counter/widgets/PurchasePopUp.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
  final Function(bool) darkModeFun;
  final bool darkON;
  SettingsPage({@required this.darkModeFun, @required this.darkON});
}

class _SettingsPageState extends State<SettingsPage> {

  StoreEngine storeSession;

  void resetProcedure(SavingSession session) {
    session.resetJson();
    session.readJson();
    setState(() {});
  }
  @override
  void initState() {
    storeSession = Provider.of<StoreEngine>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SavingSession>(context, listen: false);
    bool darkMode = widget.darkON;
    return Container(
      color: kBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: kItemPadding,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Settings', style: kTitleStyle),
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    setState(() {
                      darkMode ? darkMode = false : darkMode = true;
                    });
                    DarkMode.toggleDark(darkMode);
                    widget.darkModeFun(darkMode);
                    SavingSession.writeDarkStoredSetting(darkMode);
                  },
                  child: Row(
                    children: [
                      Text('Dark theme', style: kSettingsFont),
                      Switch(
                        value: darkMode,
                        activeColor: kToggleColor,
                        onChanged: (value) {
                          setState(() {
                            darkMode = value;
                            DarkMode.toggleDark(value);
                            widget.darkModeFun(darkMode);
                            SavingSession.writeDarkStoredSetting(darkMode);
                          });
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                Divider(),
                InkWell(
                  splashColor: Colors.blue[100],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                  child: Padding(
                    padding: kSettingsPadding,
                    child: Row(
                      children: [
                        Text('About',
                            style: kSettingsFont.copyWith(color: Colors.blue)),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                    );
                  },
                  child: Padding(
                    padding: kSettingsPadding,
                    child: Row(
                      children: [
                        Text('Privacy Policy',
                            style: kSettingsFont),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) => CalcSettingsPopUp(
                          function: () {
                            session.writeCalcSettings();
                            },
                        ),
                        backgroundColor: Colors.transparent);
                    },
                  child: Padding(
                    padding: kSettingsPadding,
                    child: Row(
                      children: [
                        Text('Adjust sensitivity',
                            style: kSettingsFont),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  splashColor: Colors.green[100],
                  onTap: () {
                    showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) => PurchasePopUp(
                          function: (donationType) {
                            storeSession.performDonation(donationType);
                          },
                        ),
                        backgroundColor: Colors.transparent);
                  },
                  child: Padding(
                    padding: kSettingsPadding,
                    child: Row(
                      children: [
                        Text('Donate',
                            style: kSettingsFont.copyWith(
                                color: Colors.green[700])),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                      child: Material(
                          elevation: 12.0,
                          shadowColor: Colors.red,
                          color: Colors.red[800],
                          borderRadius: kResetButtonBorder,
                          child: InkWell(
                            onTap: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: kBackgroundColor,
                                      title: Text('Reset data?',
                                          style: kDialogFont.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      content: Text(
                                          'Proceeding will completely wipe off your data. Are you sure you want to continue?',
                                          style: kDialogFont),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              resetProcedure(session);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes',
                                                style: kDialogFont.copyWith(
                                                    color: Colors.red[900]))),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                                Text('No', style: kDialogFont))
                                      ],
                                    );
                                  });
                            },
                            customBorder: RoundedRectangleBorder(
                                borderRadius: kResetButtonBorder),
                            splashColor: Colors.red[200],
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text('Reset your data',
                                  style: kSettingsFont.copyWith(
                                      color: Colors.white)),
                            ),
                          ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
