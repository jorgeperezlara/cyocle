class WeightData {
  DateTime date;
  double kg;
  WeightData({this.date, this.kg});

  Map toJson() => {
        'year': date.year,
        'month': date.month,
        'day': date.day,
        'weight': this.kg
      };

  factory WeightData.fromJson(Map json) {
    //un constructor .fromJson
    String day = '${json['day']}';
    String month = '${json['month']}';
    day.length == 1 ? day = '0$day' : null;
    month.length == 1 ? month = '0$month' : null;

    return WeightData(
        date: DateTime.parse('${json['year']}-$month-$day'),
        kg: json['weight']);
  }
}
