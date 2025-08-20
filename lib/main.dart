import 'package:flutter/material.dart';
import 'flashlight_page.dart';

void main() {
  runApp(const TouchlightApp());
}

class TouchlightApp extends StatelessWidget {
  const TouchlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashlightPage(),
    );
  }
}
