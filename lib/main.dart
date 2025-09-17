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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  static const Color defaultBgColor = Colors.white;

  final Random _random = Random();
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _startNewColorAnimation(
      defaultBgColor, 
      defaultBgColor
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateColor() {
    Color currentBgColor = _colorAnimation.value ?? defaultBgColor;

    // can use Color.fromARGB(...) as well to be more readable, 
    // but this way random.nextInt is called only once
    Color newBgColor = Color(
      0xFF000000 //max alpha
      + _random.nextInt( 1<<24 ) //random 0x00RRGGBB
    );

    _startNewColorAnimation(currentBgColor, newBgColor);
  }

  void _startNewColorAnimation(Color begin, Color end) {
    _colorAnimation = ColorTween(
      begin: begin,
      end: end,
    ).animate(_controller);

    _controller
    ..reset()
    ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _updateColor,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return ColoredBox(
              color: _colorAnimation.value ?? defaultBgColor,
              child: child,
            );
          },
          child: const Center(
            child: Text(
              'Hello there',
              // can use Theme.of(context).textTheme.headlineLarge
              // but having const style allows us to have const Center
              // thus not rebuilding the whole tree
              style: TextStyle(fontSize: 42),
            ),
          ),
        ),
      ),
    );
  }
}
