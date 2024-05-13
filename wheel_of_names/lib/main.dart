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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  final List<String> chosenNames1 = ["", ""];
  final List<String> chosenNames2 = ["", ""];

  final TextEditingController textBoy1 = TextEditingController();
  final TextEditingController textBoy2 = TextEditingController();

  @override
  void dispose() {
    textBoy1.dispose();
    textBoy2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: const TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.egg),),
            Tab(icon: Icon(Icons.egg_alt),)
          ]
          ),
      ),
      body: TabBarView(
        children: <Widget>[
          Wheel1Page(
            chosenNames: chosenNames1,
            textBoy: textBoy1,
          ),
          Wheel2Page(
            chosenNames: chosenNames2,
            textBoy: textBoy2,
          ),
        ]
           
        ),
      )
    );
  }
    
}

class Wheel1Page extends StatefulWidget {
  const Wheel1Page({Key? key, required this.chosenNames, required this.textBoy})
      : super(key: key);

  final List<String> chosenNames;
  final TextEditingController textBoy;

  @override
  _Wheel1PageState createState() => _Wheel1PageState();
}

class _Wheel1PageState extends State<Wheel1Page> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, widget.chosenNames.length),
            );
          });
        },
        child: Column(
         children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                items: [
                  for (var it in widget.chosenNames) FortuneItem(child: Text(it)),
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
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: widget.textBoy,
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
                  widget.chosenNames.clear();
                  String textInputs = widget.textBoy.text.trim();
                  List <String> entries = textInputs.split(',');
                  for (String entry in entries) {
                    String trimmedEntry = entry.trim();
                    if (trimmedEntry.isNotEmpty) {
                      widget.chosenNames.add(trimmedEntry);
                    }
                  }
                  if (widget.chosenNames.length < 2) {
                    widget.chosenNames.add("");
                  }
                  print(widget.chosenNames);
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
          widget.chosenNames.clear();
          widget.chosenNames.add("");
          widget.chosenNames.add("");
          setState(() {});
        },
        tooltip: 'Second action',
        child: const Icon(Icons.delete),
      ),
    ],
  ),
    );

  }

}

class Wheel2Page extends StatefulWidget {
  const Wheel2Page({Key? key, this.chosenNames = const [], required this.textBoy})
      : super(key: key);

  final List<String> chosenNames;
  final TextEditingController textBoy;

  @override
  _Wheel2PageState createState() => _Wheel2PageState();
}

class _Wheel2PageState extends State<Wheel2Page> {
  StreamController<int> selected2 = StreamController<int>();

  @override
  void dispose() {
    selected2.close();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GestureDetector(
        onTap: () {
          setState(() {
            selected2.add(
              Fortune.randomInt(0, widget.chosenNames.length),
            );
          });
        },
        child: Column(
         children: [
            Expanded(
              child: FortuneWheel(
                selected: selected2.stream,
                items: [
                  for (var it in widget.chosenNames) FortuneItem(child: Text(it)),
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
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: widget.textBoy,
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
                  widget.chosenNames.clear();
                  String textInputs = widget.textBoy.text.trim();
                  List <String> entries = textInputs.split(',');
                  for (String entry in entries) {
                    String trimmedEntry = entry.trim();
                    if (trimmedEntry.isNotEmpty) {
                      widget.chosenNames.add(trimmedEntry);
                    }
                  }
                  if (widget.chosenNames.length < 2) {
                    widget.chosenNames.add("");
                  }
                  print(widget.chosenNames);
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
          widget.chosenNames.clear();
          widget.chosenNames.add("");
          widget.chosenNames.add("");
          setState(() {});
        },
        tooltip: 'Second action',
        child: const Icon(Icons.delete),
      ),
    ],
  ),
    );

  }

}
