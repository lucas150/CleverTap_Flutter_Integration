import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:intl/intl.dart';


class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<String> imageUrls1 = [];
  List<String> imageUrls2 = [];
  var formatter = DateFormat("dd/MM/yyyy hh:mm:ss a");

  @override
  void initState() {
    super.initState();
    CleverTapPlugin.recordEvent("ct-nativedisplay",{});
    CleverTapPlugin.recordEvent("Native Display",{});
    var eventData = {
      // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'date8': formatter.format(DateTime.now()),

    };

    CleverTapPlugin.recordEvent("DateTime Event", eventData);
    _fetchNativeDisplay();
    _fetchNativeDisplay2();
  }

  void _fetchNativeDisplay() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    _onDisplayUnitsLoaded1(displayUnits);
  }

  void _fetchNativeDisplay2() async {
    await Future.delayed(const Duration(seconds: 2));
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    _onDisplayUnitsLoaded2(displayUnits);
  }

  void _onDisplayUnitsLoaded1(List<dynamic>? displayUnits) {
    if (displayUnits == null || displayUnits.isEmpty) return;
    setState(() {
      imageUrls1 = displayUnits
          .where((unit) => unit["custom_kv"]?["id"] == "native1")
          .expand((unit) => unit["content"])
          .map((content) => content["media"]?["url"])
          .whereType<String>()
          .toList();
    });
  }

  void _onDisplayUnitsLoaded2(List<dynamic>? displayUnits) {
    if (displayUnits == null || displayUnits.isEmpty) return;
    setState(() {
      imageUrls2 = displayUnits
          .where((unit) => unit["custom_kv"]?["id"] == "native2")
          .expand((unit) => unit["content"])
          .map((content) => content["media"]?["url"])
          .whereType<String>()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNativeDisplaySection("Native Display 1", imageUrls1),
            const SizedBox(height: 20),
            _buildNativeDisplaySection("Native Display 2", imageUrls2),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNativeDisplaySection(String title, List<String> imageUrls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (imageUrls.isNotEmpty)
          ...imageUrls.map(
            (url) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  url,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        else
          const Text("No images available", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
