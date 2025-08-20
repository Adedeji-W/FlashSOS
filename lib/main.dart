import 'package:flutter/material.dart';
import 'flashlight_page.dart';

void main() {
  runApp(const TouchlightApp());
}

class TouchlightApp extends StatelessWidget {
  const TouchlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FlashlightPage(),
    );
  }
}
