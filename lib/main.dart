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

    Color newBgColor = _getRandomColor();

    _startNewColorAnimation(currentBgColor, newBgColor);

    setState(() {
      //update letter colors as well
    });
  }

  Color _getRandomColor() {
    // can use Color.fromARGB(...) as well to be more readable, 
    // but this way random.nextInt is called only once
    return Color.fromRGBO(
    _random.nextInt(256), 
    _random.nextInt(256), 
    _random.nextInt(256), 
    _random.nextInt(256) / 255
  );
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
          child: Center(
            /*child: Text(
              'Hello there',
              style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: _textColor),
            ),*/
            child: RichText(
              text: TextSpan(
                children: 
                  'Hello there'
                  .split('')
                  .map<TextSpan>(
                    (s) => TextSpan(
                      text: s,
                      style: TextStyle(color: _getRandomColor()),
                    ),
                  )
                  .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
