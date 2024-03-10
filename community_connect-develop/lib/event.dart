class Date {
  final int flag; // 0:正確な日時が決まっている, 1:正確な日時が決まっていない
  final int year, month, day;
  final String description; // 正確な日時が決まっていないときの説明 例: 上旬、未定

  Date({
    required this.flag,
    required this.year,
    required this.month,
    required this.day,
    required this.description,
  });
}

class Event {
  final int id;
  final String name;
  final String place;
  final String prefecture, city;
  final Date start;
  final Date end;
  final int starttime;
  final int endtime;

  Event({
    required this.id,
    required this.name,
    required this.place,
    required this.prefecture,
    required this.city,
    required this.start,
    required this.end,
    required this.starttime,
    required this.endtime,
  });
}
