import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/engine/StoreEngine.dart';
import 'package:rpm_jack_counter/screens/screen_tree.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'engine/mic_engine.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void initializePermissions(BuildContext context) async {
    bool micPermission = await Permission.microphone.isGranted;
    bool storagePermission = await Permission.storage.isGranted;
    micPermission ? null : await Permission.microphone.request();
    storagePermission ? null : await Permission.storage.request();
    micPermission = await Permission.microphone.isGranted;
    storagePermission = await Permission.storage.isGranted;
    if (micPermission && storagePermission) {
    } else {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No permissions granted',
                  style: kDialogFont.copyWith(fontWeight: FontWeight.bold)),
              content: Text(
                  'You have not granted the app permissions to access your microphone and/or your storage. Please, consider doing so, no information will be sent to our servers, everything is processed on-device, and without these permissiosn the app will be unable to work.',
                  style: kDialogFont),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok', style: kDialogFont),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    SavingSession session = SavingSession();
    StoreEngine storeSession = StoreEngine();
    MicrophoneEngine micEngine = MicrophoneEngine(session.oddOnly, session.filterValue);
    session.readJson();
    initializePermissions(context);
    return Provider<StoreEngine>(
      create: (context) => storeSession,
      child: Provider<SavingSession>(
          create: (context) => session,
          child: Provider<MicrophoneEngine>(
            create: (context) => micEngine,
            child: MaterialApp(
              home: ScreenTree(),
            ),
          )),
    );
  }
}
