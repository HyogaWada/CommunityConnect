import 'event.dart';
import 'matsumotocsv.dart';
import 'dart:async';

Future<List<Event>> query1(String prefevture, String city) async {
  if (prefevture == '新潟県' && city == '三条市') {
    // final eventlist = getlist_1_1();
    // return eventlist;
  } else if (prefevture == '長野県' && city == '松本市') {
    final eventlist = getlist_1_2();
    return eventlist;
  } else if (prefevture == '静岡県' && city == '伊藤市') {
    // final eventlist = getlist_1_3();
    // return eventlist;
  }
  List<Event> eventlist = [];
  return eventlist;
}

Future<List<Event>> query2(String prefevture, String city, int month) async {
  if (prefevture == '新潟県' && city == '三条市') {
    // final eventlist = getlist_2_1(month);
    // return eventlist;
  } else if (prefevture == '長野県' && city == '松本市') {
    final eventlist = getlist_2_2(month);
    return eventlist;
  } else if (prefevture == '静岡県' && city == '伊藤市') {
    // final eventlist = getlist_2_3(month);
    // return eventlist;
  }
  List<Event> eventlist = [];
  return eventlist;
}

Future<List<Event>> query3(
    String prefevture, String city, int month, int day) async {
  if (prefevture == '新潟県' && city == '三条市') {
    // final eventlist = getlist_3_1(month, day);
    // return eventlist;
  } else if (prefevture == '長野県' && city == '松本市') {
    final eventlist = getlist_3_2(month, day);
    return eventlist;
  } else if (prefevture == '静岡県' && city == '伊藤市') {
    // final eventlist = getlist_3_3(month, day);
    // return eventlist;
  }
  List<Event> eventlist = [];
  return eventlist;
}
