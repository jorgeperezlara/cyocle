import 'package:rpm_jack_counter/dataClasses/weight_data.dart';

abstract class Calculations {
  static String formatDateFromSecs(int dateInSeconds) {
    int hours = dateInSeconds ~/ (60 * 60);
    int minutes = (dateInSeconds % (60 * 60)) ~/ 60;
    int seconds = ((dateInSeconds % (60 * 60)) % 60);
    String hourString = hours.toString();
    String minString = minutes.toString();
    String secString = seconds.toString();
    hourString.length != 2 ? hourString = '0$hourString' : hourString;
    minString.length != 2 ? minString = '0$minString' : minString;
    secString.length != 2 ? secString = '0$secString' : secString;
    return ('$hourString:$minString:$secString');
  }

  static String calculateVariation(List<WeightData> weightList, int index) {
    List<String> variationList = [
      '–'
    ]; //siempre el primero es – porque no se puede calcular OBVIO.
    for (int i = 1; i < weightList.length; i++) {
      double difference = weightList[i].kg - weightList[i - 1].kg;
      double variation =
          weightList[i - 1].kg == 0 ? 0 : difference / weightList[i - 1].kg;
      String percentage = (variation * 100).toStringAsFixed(0);
      variationList.add('$percentage%');
    }
    return variationList[index];
  }

  static int calculateRPM(int laps, int seconds) {
    double revPerSecond = seconds == 0 ? 0 : laps / seconds;
    double rpm = revPerSecond * 60;
    return rpm.toInt();
  }

  static int calculateAverageRPM(List<int> rpmList, int index) {
    var total = 0;
    for (var values in rpmList) {
      total = total + values;
    }
    return (total ~/ index);
  }

  static int getMaxRPM(List<int> rpmList) {
    var maxRPM = 0;
    for (var value in rpmList) {
      value > maxRPM ? maxRPM = value : null;
    }
    return maxRPM;
  }
}
