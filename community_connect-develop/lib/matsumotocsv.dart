import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'event.dart';

extension Compare on int {
  int next(int Function() func) {
    return this == 0 ? func() : this;
  }
}

class Pair {
  final Date start, end;

  Pair({
    required this.start,
    required this.end,
  });
}

Pair getDate(String S) {
  int startM = 0, startD = 0, endM = 0, endD = 0, num = 0;
  String T = '', startT = '', endT = '';
  for (int i = 0; i < S.length; i++) {
    if (S[i] == '1' || S[i] == '１') {
      num *= 10;
      num += 1;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '2' || S[i] == '２') {
      num *= 10;
      num += 2;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '3' || S[i] == '３') {
      num *= 10;
      num += 3;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '4' || S[i] == '４') {
      num *= 10;
      num += 4;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '5' || S[i] == '５') {
      num *= 10;
      num += 5;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '6' || S[i] == '６') {
      num *= 10;
      num += 6;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '7' || S[i] == '７') {
      num *= 10;
      num += 7;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '8' || S[i] == '８') {
      num *= 10;
      num += 8;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '9' || S[i] == '９') {
      num *= 10;
      num += 9;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '0' || S[i] == '０') {
      num *= 10;
      num += 0;
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
    } else if (S[i] == '月') {
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
      if (startM == 0) {
        startM = num;
        num = 0;
      } else if (endM == 0) {
        endM = num;
        num = 0;
      }
    } else if (S[i] == '日') {
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
      if (startD == 0) {
        startD = num;
        num = 0;
      } else if (endD == 0) {
        if (endM == 0) {
          endM = startM;
        }
        endD = num;
        num = 0;
      }
    } else if (S[i] == '～' || S[i] == '、' || S[i] == '・') {
      if (T.length != 0) {
        if (startT.length == 0) {
          startT = T;
          T = '';
        }
      } else {
        endT = T;
        T = '';
      }
      continue;
    } else {
      T += S[i];
    }
  }
  if (endM == 0) {
    endM = startM;
  }
  if (startT == '上' || startT == '中' || startT == '下') {
    startT += '旬';
  }
  if (startT.length == 0) {
    if (T.length > 0) {
      startT = T;
    }
  } else if (endT.length == 0) {
    if (T.length > 0) {
      endT = T;
    } else {
      endT = startT;
    }
  }
  int startF = 1, endF = 1;
  if (startM != 0 && startD != 0) {
    startF = 0;
  }
  if (endM != 0 && endD != 0) {
    endF = 0;
  }

  return Pair(
      start: Date(
          flag: startF,
          year: 2023,
          month: startM,
          day: startD,
          description: startT),
      end: Date(
          flag: endF, year: 2023, month: endM, day: endD, description: endT));
}

Future<List<Event>> getlist_1_2() async {
  const String importPath = 'assets/data/ivento_itiran.csv';
  List<List> importList = [];
  List<Event> eventlist = [];
  String csvData = await rootBundle.loadString(importPath);
  List<String> lines = LineSplitter().convert(csvData);
  int count0 = 0, count1 = 0;
  for (var line in lines) {
    importList.add(line.split(','));
    if (count0 >= 9) {
      String S = importList[count0][4];
      Pair P = getDate(S);
      if (P.start.month != 0) {
        eventlist.add(Event(
            id: 200000 + count1,
            name: importList[count0][1],
            place: importList[count0][6],
            prefecture: '長野県',
            city: '松本市',
            start: P.start,
            end: P.end,
            starttime: -1,
            endtime: -1));
        count1 += 1;
      }
    }
    count0 += 1;
  }

  eventlist.sort(((a, b) => a.start.month
      .compareTo(b.start.month)
      .next(() => a.start.day.compareTo(b.start.day))));

  return eventlist;
}

Future<List<Event>> getlist_2_2(int month) async {
  const String importPath = 'assets/data/ivento_itiran.csv';
  List<List> importList = [];
  List<Event> eventlist = [];

  String csvData = await rootBundle.loadString(importPath);
  List<String> lines = LineSplitter().convert(csvData);

  int count0 = 0, count1 = 0;
  for (var line in lines) {
    importList.add(line.split(','));
    if (count0 >= 9) {
      String S = importList[count0][4];
      Pair P = getDate(S);
      if (P.start.month <= month && P.end.month >= month) {
        int stm = P.start.month;
        int std = P.start.day;
        int edm = P.end.month;
        int edd = P.end.day;
        if (stm < month) {
          stm = month;
          std = 1;
        }
        if (edm > month) {
          edm = month;
          if (edm == 2) {
            edd = 28;
          } else if (edm == 4 || edm == 6 || edm == 9 || edm == 11) {
            edd = 30;
          } else {
            edd = 31;
          }
        }
        eventlist.add(Event(
            id: 200000 + count1,
            name: importList[count0][1],
            place: importList[count0][6],
            prefecture: '長野県',
            city: '松本市',
            start: Date(
                flag: P.start.flag,
                year: P.start.year,
                month: stm,
                day: std,
                description: P.start.description),
            end: Date(
                flag: P.end.flag,
                year: P.end.year,
                month: edm,
                day: edd,
                description: P.end.description),
            starttime: -1,
            endtime: -1));
        count1 += 1;
      }
    }
    count0 += 1;
  }

  eventlist.sort(((a, b) => a.start.month
      .compareTo(b.start.month)
      .next(() => a.start.day.compareTo(b.start.day))));

  return eventlist;
}

Future<List<Event>> getlist_3_2(int month, int day) async {
  const String importPath = 'assets/data/ivento_itiran.csv';
  List<List> importList = [];
  List<Event> eventlist = [];

  String csvData = await rootBundle.loadString(importPath);
  List<String> lines = LineSplitter().convert(csvData);

  int count0 = 0, count1 = 0;
  for (var line in lines) {
    importList.add(line.split(','));
    if (count0 >= 9) {
      String S = importList[count0][4];
      Pair P = getDate(S);
      if ((P.start.month < month ||
              (P.start.month == month && P.start.day <= day)) &&
          (P.end.month > month || (P.end.month == month && P.end.day >= day))) {
        eventlist.add(Event(
            id: 200000 + count1,
            name: importList[count0][1],
            place: importList[count0][6],
            prefecture: '長野県',
            city: '松本市',
            start: P.start,
            end: P.end,
            starttime: -1,
            endtime: -1));
        count1 += 1;
      }
    }
    count0 += 1;
  }

  eventlist.sort(((a, b) => a.start.month
      .compareTo(b.start.month)
      .next(() => a.start.day.compareTo(b.start.day))));

  return eventlist;
}
