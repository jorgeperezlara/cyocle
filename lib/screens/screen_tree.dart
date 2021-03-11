import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpm_jack_counter/dataClasses/weight_data.dart';
import 'package:rpm_jack_counter/engine/DarkMode.dart';
import 'package:rpm_jack_counter/engine/SaveEngine.dart';
import 'package:rpm_jack_counter/engine/StoreEngine.dart';
import 'package:rpm_jack_counter/engine/calculator.dart';
import 'package:rpm_jack_counter/engine/mic_engine.dart';
import 'package:rpm_jack_counter/screens/settings.dart';
import 'package:rpm_jack_counter/screens/statistics.dart';
import 'package:rpm_jack_counter/screens/weight_screen.dart';
import 'package:rpm_jack_counter/values/constants.dart';
import 'package:rpm_jack_counter/widgets/FABbutton.dart';
import 'package:rpm_jack_counter/widgets/WeightPopUpInputCard.dart';
import 'package:rpm_jack_counter/widgets/navbar.dart';
import 'home.dart';

class ScreenTree extends StatefulWidget {
  ScreenTree({Key key}) : super(key: key);
  @override
  _ScreenTreeState createState() => _ScreenTreeState();
}

class _ScreenTreeState extends State<ScreenTree>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  SavingSession session;
  StoreEngine storeSession;

  bool _isPlaying;
  int _index;
  int _rpm;
  List<int> _rpmList = [];
  int _maxRPM = 0;
  int _averageRPM = 0;
  List<Widget> bodyList;
  int _indexOfRPM = 0;
  int _durationInSecs = 0;
  bool darkON = false;

  Future<void> readDarkSetting() async {
    darkON = await SavingSession.readDarkStoredSetting();
    DarkMode.toggleDark(darkON);
    setState(() {});
  }

  Widget chooseFAB(int index, BuildContext context) {
    final micEngine = Provider.of<MicrophoneEngine>(context, listen: false);
    session = Provider.of<SavingSession>(context, listen: false);
    var playSaveFAB = PlaySaveFAB(
      isPlaying: _isPlaying,
      onPressed: () {
        Stopwatch watch = Stopwatch();
        if (_isPlaying) {
          watch.stop();
          setState(() {
            _isPlaying = false;
          });
          micEngine.stopRecording();
          session.saveRPM(
              _maxRPM, _averageRPM, DateTime.now(), _durationInSecs);
          session.saveJson(session.statInJson(), FileName.stat);
        } else {
          watch.start();
          _durationInSecs = watch.elapsed.inSeconds;
          setState(() {
            _isPlaying = true;
          });
          micEngine.startRecording((laps) {
            setState(() {
              _rpm = Calculations.calculateRPM(laps, watch.elapsed.inSeconds);
            });
            _indexOfRPM++;
            _rpmList = [..._rpmList, _rpm];
            setState(() {
              _maxRPM = Calculations.getMaxRPM(_rpmList);
              _averageRPM =
                  Calculations.calculateAverageRPM(_rpmList, _indexOfRPM);
              _durationInSecs = watch.elapsed.inSeconds;
            });
          });
        }
      },
    );
    var addWeightFAB = AddWeightFAB(onPressed: () {
      showModalBottomSheet<void>(
        isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => InputPopUpCard(
                function: (weight) {
                  WeightData newWeightData =
                      WeightData(date: DateTime.now(), kg: weight);
                  session.listOfWeights = [
                    ...session.listOfWeights,
                    newWeightData
                  ];
                  session.saveJson(session.weightInJson(), FileName.weight);
                  setState(() {});
                },
              ),
          backgroundColor: Colors.transparent);
    });

    return index == 2 ? addWeightFAB : playSaveFAB;
  }

  @override
  void dispose() {
    storeSession.disposePlugin();
    super.dispose();
  }

  @override
  void initState() {
    session = Provider.of<SavingSession>(context, listen: false);
    storeSession = Provider.of<StoreEngine>(context, listen: false);
    session.readCalcSettings();
    controller = AnimationController(
        //inicializamos la animación
        duration: const Duration(milliseconds: 200),
        vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    controller.addListener(() {
      setState(() {});
    });
    _isPlaying = false;
    _rpm = 0;
    _index =
        0; //seteamos en el init el estado inicial de la configuración de las variables. Para evitar bugs, no debe ir en el initializer de la clase, si no que la declaración de variables debe ir en el initState.
    readDarkSetting();

    storeSession.initializePlugin();
    storeSession.loadPurchaseStream();
    storeSession.grabPurchases();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Aaaaamigo, cada vez que hacemos un setState se triggea un build, creo, por lo que si no seteamos pageDisplayed en el build, no se reconstruirá con el setState.
    //Ahora hemos hecho en el build que dependa del index. Si cambia el index, se tiene que reconstruir la interfaz de acuerdo a ese index. Realmente no entiendo por qué antes no y ahora sí funciona.
    //La variable darkON realmente sólo hace falta en los constructores de los 2 widgets que se tienen que reconstruir en caso de cambiar la variable: al inicio (home) y en al cambiar su valor (settings).
    bodyList = [
      HomePage(
          rpm: _rpm,
          averageRPM: _averageRPM,
          maxRPM: _maxRPM,
          durationInSeconds: _durationInSecs),
      StatisticsScreen(),
      WeightScreen(),
      SettingsPage(
        darkON: this.darkON,
        darkModeFun: (darkON) {
          this.darkON = darkON;
          DarkMode.toggleDark(darkON);
          setState(() {});
        },
      )
    ];

    controller.forward();
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: FABNavBar(
        controllerFun: () {
          setState(() {
            controller.reset();
            controller.forward();
          });
        },
        darkON: this.darkON,
        items: [
          FABBottomAppBarItem(
            label: 'Home',
            icon: Icons.home,
          ),
          FABBottomAppBarItem(label: 'Stats', icon: Icons.trending_up),
          FABBottomAppBarItem(label: 'Weight', icon: Icons.pie_chart),
          FABBottomAppBarItem(label: 'Settings', icon: Icons.settings)
        ],
        returnIndex: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: chooseFAB(_index, context),
      body: Opacity(opacity: animation.value, child: bodyList[_index]),
    );
  }
}
