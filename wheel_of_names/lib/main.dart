import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheel of Names',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wheel of Names'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> selected = StreamController<int>();

  final textBoy = TextEditingController();

  var chosenNames = <String>[
    "",
    "",
  ];

  @override
  void dispose() {
    textBoy.dispose();
    selected.close();
    super.dispose();
  }

  void commit(){
      Navigator.of(context).pop();
    }

  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, chosenNames.length),
            );
          });
        },
        child: Column(
         children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                items: [
                  for (var it in chosenNames) FortuneItem(child: Text(it)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:  Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Add a Word'),
            content: TextField(
              controller: textBoy,
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter a word',),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  chosenNames.remove("");
                  chosenNames.add(textBoy.text);
                  print(chosenNames);
                  textBoy.clear();
                  setState(() {});
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          )
        ),
        tooltip: 'Add a word',
        child: const Icon(Icons.add),
      ),
      SizedBox(height: 16), // Adjust as needed for spacing
      FloatingActionButton(
        onPressed: () {
          chosenNames.clear();
          chosenNames.add("");
          chosenNames.add("");
          setState(() {});
        },
        tooltip: 'Second action',
        child: const Icon(Icons.delete),
      ),
    ],
  ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
    
}
