import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'chat_screen.dart';
import 'news_page.dart';
import 'flyer_page.dart';
import 'event.dart';
import 'query.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja_JP', null);
  runApp(CommunityConnectApp());
}

class CommunityConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'こみゅこね!',
      home: Scaffold(
        appBar: AppBar(
          title: Text('こみゅこね!'),
        ),
        body: MainMenu(),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // 都道府県と市区町村の選択肢
  final List<Map<String, dynamic>> locations = [
    {'prefecture': '長野県', 'city': '松本市'},
    {'prefecture': '新潟県', 'city': '三条市'}
  ];

  String selectedPrefecture = '長野県';
  String selectedCity = '松本市';
  List<Event> events = [];

  // 長野県松本市のイベント情報を取得する関数
  Future<void> fetchMatsumotoEvents() async {
    if (selectedPrefecture == '長野県' && selectedCity == '松本市') {
      try {
        events = await query1(selectedPrefecture, selectedCity);
        // ここで取得したイベント情報を表示するロジックを実装
        // 例: showDialog でイベントリストを表示
        for (var event in events) {
          print(
              'Event ID: ${event.id}, Name: ${event.name}, Place: ${event.place}, Prefecture: ${event.prefecture}, City: ${event.city}, Start: ${event.start.month}, End: ${event.end.month}, Starttime: ${event.starttime}, Endtime: ${event.endtime}');
        }
      } catch (e) {
        // エラーハンドリング
        print('イベント情報の取得に失敗しました: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_01.jpg'), // 背景画像の設定
          fit: BoxFit.cover, // 画面全体に画像を広げる
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 都道府県選択
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedPrefecture,
                      items: locations.map((location) {
                        return DropdownMenuItem<String>(
                          value: location['prefecture'],
                          child: Text(location['prefecture']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedPrefecture = newValue;
                            selectedCity = locations.firstWhere(
                                (location) =>
                                    location['prefecture'] == newValue,
                                orElse: () => locations[0])['city'];
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  // 市区町村選択
                  Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCity,
                      items: locations
                          .where((location) =>
                              location['prefecture'] == selectedPrefecture)
                          .map((location) {
                        return DropdownMenuItem<String>(
                          value: location['city'],
                          child: Text(location['city']),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCity = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchMatsumotoEvents();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content:
                          Text('選択された場所: $selectedPrefecture $selectedCity'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('閉じる'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('選択を確定する'),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarScreen(
                                  events: events,
                                )),
                      );
                    },
                    icon: Image.asset('assets/images/event.png', width: 24),
                    label: Text('イベント'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    icon: Image.asset('assets/images/question.png', width: 24),
                    label: Text('教えて'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FlyerPage()),
                      );
                    },
                    icon: Image.asset('assets/images/flyer.png', width: 24),
                    label: Text('チラシ'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // グループボタンの処理をここに追加
                    },
                    icon: Image.asset('assets/images/group.png', width: 24),
                    label: Text('グループ'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsPage()),
                      );
                    },
                    icon: Image.asset('assets/images/news.png', width: 24),
                    label: Text('ニュース'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight / 5),
              child: Text(
                '直近のイベント',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () async {
                  const url = 'https://yamazakitakashi-exhibition.com/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: screenWidth / 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
