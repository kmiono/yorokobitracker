import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_homeru_page.dart';
import 'homeru_page.dart';

const incrementKey = 'increment';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counterExercise = 0;
  bool _valueFlg = false;

  void _incrementCounter() {
    setState(() {
      if (_valueFlg) {
        _counter++;
      }
      _setPrefItems(); // Shared Preferenceに値を保存する。
    });
  }

  String get _message {
    String _messageText;
    String _messageCounter;
    if (_valueFlg) {
      _messageText = "運動頑張った回数:";
    } else {
      _messageText = "頑張った回数:";
    }
    return _messageText;
  }

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      // 以下の「counter」がキー名。見つからなければ０を返す
      _counter = pref.getInt('counter') ?? 0;
      _counterExercise = pref.getInt('counterExercise') ?? 0;
    });
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    pref.setInt('counter', _counter);
    pref.setInt('counterExercise', _counterExercise);
  }

  // Shared Preferenceのデータを削除する
  _removePrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      _counter = 0;
      _counterExercise = 0;
      // 以下の「counter」がキー名。
      pref.remove('counter');
      pref.remove('counterExercise');
    });
  }

  @override
  void initState() {
    super.initState();
    // 初期化時にShared Preferencesに保存している値を読み込む
    _getPrefItems();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ほめるビットラッカー"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //追加
            Text(_message),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //追加ここまで
            DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: false,
                    child: Text("とにかくほめる"),
                  ),
                  DropdownMenuItem(
                    value: true,
                    child: Text("運動した"),
                  ),
                ],
                value: _valueFlg,
                onChanged: (bool? value) {
                  setState(() {
                    _valueFlg = value!;
                  });
                }),
            OutlinedButton(
              child: const Text(
                'ほめる',
                style: TextStyle(fontSize: 50),
              ),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(250, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return HomeruPage();
                }))
              },
            ),
          ],
        ),
      ),
    );
  }
}
