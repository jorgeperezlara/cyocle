class Statistic {
  DateTime date;
  int averageRPM;
  int maxRPM;
  int totalDurationSec;

  Statistic({this.date, this.averageRPM, this.maxRPM, this.totalDurationSec});

  Map<String, dynamic> toJson() => {
        'day': date.day,
        'month': date.month,
        'year': date.year,
        'avgRPM': averageRPM,
        'maxRPM': maxRPM,
        'duration': totalDurationSec
      };
  factory Statistic.fromJson(json) {
    //un constructor .fromJson
    String day = json['day'].toString();
    String month = json['month'].toString();
    day.length == 1 ? day = '0$day' : null;
    month.length == 1 ? month = '0$month' : null;

    return Statistic(
        date: DateTime.parse('${json['year']}-$month-$day'),
        averageRPM: json['avgRPM'],
        maxRPM: json['maxRPM'],
        totalDurationSec: json['duration']);
  }
}
