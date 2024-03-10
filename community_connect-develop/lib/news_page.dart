import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; //add

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  //OKコード
  Future<List<dynamic>> fetchNews() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=jp&apiKey=68e8422ad8794088a191bfe41eaa882e';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ニュース'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var article = snapshot.data![index];
                return Card(
                  child: Container(
                    height: 200,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            article['urlToImage'] ??
                                'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                // Centerウィジェットを使用
                                child: Text('No image'),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            title: Text(article['title'] ?? 'ニュースタイトルなし'),
                            subtitle: Text(article['description'] ?? '詳細なし'),
                            onTap: () {
                              _launchURL(article['url']);
                              print('ニュース ${article['title']} がタップされました');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('ニュースの取得に失敗しました'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
