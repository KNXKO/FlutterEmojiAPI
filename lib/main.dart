// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'emoji_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter emoji name and icon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Emoji> _emoji = [];
  int _currentEmojiIndex = 0;
  bool _showListView = true;

  Future<List<Emoji>> _loadEmoji() async {
    var url = Uri.parse('https://emojihub.yurace.pro/api/all');
    var response = await http.get(url);
    final result = resultFromJson(response.body);
    return result;
  }

  void _loadAndShowEmoji() async {
    setState(() {
      _emoji = [];
    });

    var emoji = await _loadEmoji();

    setState(() {
      _emoji = emoji;
    });
  }

  // function to convert emoji html code to display
  String _decodeHtmlEmoji(String text) {
    return parse(text).body!.text;
  }

  @override
  Widget build(BuildContext context) {
    // If the emoji list is empty, load the emoji
    if (_emoji.isEmpty) {
      _loadAndShowEmoji();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // loading icon
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'The current emoji name and icon',
          ),
          Text(
            _emoji.isEmpty
                ? "Failed to load emojis"
                : "${_emoji[_currentEmojiIndex].name} ${_decodeHtmlEmoji(_emoji[_currentEmojiIndex].htmlCode[0])}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Visibility(
            visible: _showListView,
            child: Expanded(
              child: ListView.builder(
                itemCount: _emoji.length,
                itemBuilder: (BuildContext context, int i) => Card(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      _emoji[_currentEmojiIndex].name == _emoji[i].name
                          ? _emoji[i].name
                          : '',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _showListView = !_showListView; // Toggle the flag
                  });
                },
                tooltip: _showListView ? 'Hide List' : 'Show List',
                child: _showListView
                    ? const Icon(Icons.filter_list_off)
                    : const Icon(Icons.filter_list),
              ),
              FloatingActionButton(
                onPressed: () {
                  _currentEmojiIndex += 1;
                  _loadAndShowEmoji();
                },
                tooltip: 'Next Emoji',
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
