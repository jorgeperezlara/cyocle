import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rpm_jack_counter/dataClasses/statData.dart';
import 'package:rpm_jack_counter/dataClasses/weight_data.dart';
import 'package:rpm_jack_counter/values/constants.dart';

class SavingSession {
  List<Statistic> listOfStats = [];
  List<WeightData> listOfWeights = [];
  bool oddOnly = true;
  double filterValue = 1.5;

  void saveWeight(double weight) {
    var weightdata = WeightData(date: DateTime.now(), kg: weight);
    listOfWeights.add(weightdata);
  }

  void removeItemAt(FileName fileName, int index) {
    if (fileName == FileName.stat) {
      listOfStats.removeAt(index);
      saveJson(statInJson(), fileName);
    } else {
      listOfWeights.removeAt(index);
      saveJson(weightInJson(), fileName);
    }
  }

  List<Statistic> saveRPM(
      int maxRPM, int averageRPM, DateTime date, int durationInSecs) {
    var stat = Statistic(
        maxRPM: maxRPM,
        averageRPM: averageRPM,
        date: date,
        totalDurationSec: durationInSecs);
    listOfStats.add(stat);
    return listOfStats;
  }

  String statInJson() {
    return jsonEncode(listOfStats);
  }

  String weightInJson() {
    return jsonEncode(listOfWeights);
  }

  Future<File> saveJson(String jsonText, FileName fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = fileName == FileName.stat ? 'stat' : 'weight';
    final saveFile = File('${directory.path}/$name.json');
    saveFile.delete();
    print('proceeding to write $name.json');
    return saveFile.writeAsString(jsonText);
  }

  Future<void> readJson() async {
    var directory = await getApplicationDocumentsDirectory();
    var saveFile = File('${directory.path}/stat.json');
    String jsonText;
    var jsonContent;

    try {
      jsonText = await saveFile.readAsString();
      jsonContent = jsonDecode(jsonText);
      for (var object in jsonContent) {
        listOfStats.add(Statistic.fromJson(object));
      }
    } catch (e) {
      resetJson();
      print('failure to read the stats file');
    }

    saveFile = File('${directory.path}/weight.json');
    try {
      jsonText = await saveFile.readAsString();
      jsonContent = jsonDecode(jsonText);
      for (var object in jsonContent) {
        listOfWeights.add(WeightData.fromJson(object));
      }
    } catch (e) {
      resetJson();
      print('failure to read the weights file');
    }
  }

  Future<void> resetJson() async {
    listOfStats = [];
    listOfWeights = [];
    oddOnly = true;
    filterValue = 1.5;
    final directory = await getApplicationDocumentsDirectory();
    var saveFile = File('${directory.path}/stat.json');
    try{
      saveFile.delete();
    }catch(e){
      print('No stat file detected');
    }
    saveFile.writeAsString('');
    saveFile = File('${directory.path}/weight.json');
    try{
      saveFile.delete();
    }catch(e){
      print('No weight file detected');
    }
    saveFile.writeAsString('');
    saveFile = File('${directory.path}/dark.json');
    try{
      saveFile.delete();
    }catch(e){
      print('No dark file detected');
    }
    saveFile.writeAsString('');
    saveFile = File('${directory.path}/calcSettings.json');
    try{
      saveFile.delete();
    }catch(e){
      print('No calculation settings file detected');
    }
    saveFile.writeAsString('');
    print('Reset complete!');
  }

  static Future<bool> readDarkStoredSetting() async {
    bool darkMode = false;
    final directory = await getApplicationDocumentsDirectory();
    var darkFile = File('${directory.path}/dark.json');
    String darkJson;
    var jsonContent;
    try {
      darkJson = await darkFile.readAsString();
      jsonContent = jsonDecode(darkJson);
      print('dark setting read');
      return jsonContent['darkMode'];
    } catch (e) {
      print('dark setting read');
      return darkMode;
    }
  }

  static Future<void> writeDarkStoredSetting(bool darkModeValue) async {
    final directory = await getApplicationDocumentsDirectory();
    var darkFile = File('${directory.path}/dark.json');
    Map<String, bool> jsonToEncode = {'darkMode': darkModeValue};
    var jsonDark = jsonEncode(jsonToEncode);
    darkFile.writeAsString(jsonDark);
    print('Dark setting written!');
  }

  void readCalcSettings() async {
    final directory = await getApplicationDocumentsDirectory();
    var settingsFile = File('${directory.path}/calcSettings.json');
    String settingsJSON;
    var jsonContent;
    try {
      settingsJSON = await settingsFile.readAsString();
      jsonContent = jsonDecode(settingsJSON);
      print('calculation setting read');
      oddOnly = jsonContent['oddOnly'];
      filterValue = jsonContent['filterValue'];
    } catch (e) {
      oddOnly = true;
      filterValue = 1.5;
    }
  }

  Future<void> writeCalcSettings() async {
    final directory = await getApplicationDocumentsDirectory();
    var calcSettings = File('${directory.path}/calcSettings.json');
    Map<String, dynamic> jsonToEncode = {'oddOnly': oddOnly, 'filterValue': filterValue};
    var jsonSettings = jsonEncode(jsonToEncode);
    calcSettings.writeAsString(jsonSettings);
    print('Dark setting written!');
  }
}
