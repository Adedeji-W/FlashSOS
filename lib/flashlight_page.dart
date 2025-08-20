import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:permission_handler/permission_handler.dart';

class FlashlightPage extends StatefulWidget {
  const FlashlightPage({super.key});

  @override
  State<FlashlightPage> createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  bool isOn = false;
  TextEditingController morseController = TextEditingController();

  // Morse code map
  static const Map<String, String> morseCodeMap = {
    'A': ".-",
    'B': "-...",
    'C': "-.-.",
    'D': "-..",
    'E': ".",
    'F': "..-.",
    'G': "--.",
    'H': "....",
    'I': "..",
    'J': ".---",
    'K': "-.-",
    'L': ".-..",
    'M': "--",
    'N': "-.",
    'O': "---",
    'P': ".--.",
    'Q': "--.-",
    'R': ".-.",
    'S': "...",
    'T': "-",
    'U': "..-",
    'V': "...-",
    'W': ".--",
    'X': "-..-",
    'Y': "-.--",
    'Z': "--..",
    '1': ".----",
    '2': "..---",
    '3': "...--",
    '4': "....-",
    '5': ".....",
    '6': "-....",
    '7': "--...",
    '8': "---..",
    '9': "----.",
    '0': "-----",
    ' ': "/",
  };

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    await Permission.camera.request();
  }

  Future<void> _toggleFlashlight() async {
    try {
      if (isOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isOn = !isOn;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Flashlight not available: $e")));
    }
  }

  Future<void> flashMorse(String text) async {
    for (var char in text.toUpperCase().split('')) {
      String? morse = morseCodeMap[char];
      if (morse == null) continue;

      for (var symbol in morse.split('')) {
        if (symbol == '.') {
          await TorchLight.enableTorch();
          await Future.delayed(const Duration(milliseconds: 200)); // dot
        } else if (symbol == '-') {
          await TorchLight.enableTorch();
          await Future.delayed(const Duration(milliseconds: 600)); // dash
        }
        await TorchLight.disableTorch();
        await Future.delayed(
          const Duration(milliseconds: 200),
        ); // between symbols
      }
      await Future.delayed(
        const Duration(milliseconds: 600),
      ); // between letters
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔘 Main flashlight button
            GestureDetector(
              onTap: _toggleFlashlight,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: isOn ? Colors.yellow : Colors.grey[800],
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (isOn)
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.7),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                  ],
                ),
                child: Icon(
                  isOn ? Icons.flashlight_on : Icons.flashlight_off,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // ✏️ Text input for Morse code
            TextField(
              controller: morseController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter message (HELP, HAPPY, etc.)",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                filled: true,
                fillColor: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 20),

            // 🚨 Morse code button
            ElevatedButton(
              onPressed: () {
                if (morseController.text.trim().isNotEmpty) {
                  flashMorse(morseController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Send as Morse"),
            ),
          ],
        ),
      ),
    );
  }
}
