import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  Random random = Random();
  Color bgColor = Colors.white;

  void _updateColor() {
    setState(() {

      // can use Color.fromARGB(...) as well to be more readable, 
      // but this way random.nextInt is called only once
      bgColor = Color(
          0xFF000000 //max alpha
          + random.nextInt( 1<<24 ) //random 0x00RRGGBB
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _updateColor,
        child: ColoredBox(
          color: bgColor,
          child: const Center(
            child: Text(
              'Hello there',
            ),
          ),
        ),
      ),
    );
  }
}
