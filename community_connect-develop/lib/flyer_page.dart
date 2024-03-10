import 'package:flutter/material.dart';

class FlyerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チラシ'),
      ),
      body: ListView.builder(
        itemCount: 10, // チラシアイテムの数
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              height: 200, // チラシアイテムの高さ
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1, // 左側の画像エリア（全体の四分の一）
                    child: Image.network(
                      'https://via.placeholder.com/150', // 仮の画像URL
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Center(child: Text('No image')); // エラー時の処理
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3, // 右側のテキストエリア（残りの四分の三）
                    child: ListTile(
                      title: Text('チラシアイテム $index'), // 見出し
                      subtitle: Text('チラシのサブタイトル $index'), // サブタイトル
                      onTap: () {
                        print('チラシ $index がタップされました');
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
