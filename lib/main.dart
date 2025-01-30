// import 'package:flutter/material.dart';
// import 'package:clevertap_plugin/clevertap_plugin.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Clevertap_Flutter_Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   List<String> imageURls = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeCleverTap();
//     CleverTapPlugin.setDebugLevel(3);
//   }

//   void _initializeCleverTap() {
//     var stuff = ["bags", "shoes"];
//     var values = [DateTime.parse('20250130'), DateTime.parse('20250210')];
//     CleverTapPlugin.profileSetMultiValues("End Policy Dates Multiple", values);
//     var profile = {
//       'Name': 'Captain America',
//       'Identity': '25',
//       'Email': 'chebd@america.com',
//       'Phone': '+14121234',
//       'stuff': stuff,
//     };

//     // Call CleverTap onUserLogin method with profile data
//     CleverTapPlugin.onUserLogin(profile);
//     CleverTapPlugin.createNotificationChannel(
//         "henil123", "Flutter Test", "Flutter Test", 3, true);

//     // Initialize CleverTap Inbox
//     CleverTapPlugin.initializeInbox();

//     // Set the CleverTap inbox did initialize handler inside initState
//     CleverTapPlugin().setCleverTapInboxDidInitializeHandler(() {
//       inboxDidInitialize();
//     });
//     CleverTapPlugin()
//         .setCleverTapInboxMessagesDidUpdateHandler(inboxMessagesDidUpdate);

//     void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//       this.setState(() {
//         print("Display Units = " + displayUnits.toString());
//       });
//     }

//     CleverTapPlugin()
//         .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
//   }

//   void inboxDidInitialize() {
//     setState(() {
//       debugPrint(
//           "inboxDidInitialize called"); // Use debugPrint instead of print
//       var styleConfig = {
//         'noMessageTextColor': '#ff6600', // Custom text color for "no message"
//         'noMessageText':
//             'No message(s) to show.', // Custom message when no inbox message is available
//         'navBarTitle': 'App Inbox' // Custom title for the inbox navigation bar
//       };
//       // Show the inbox with the provided style configuration
//       CleverTapPlugin.showInbox(styleConfig);
//     });
//   }

//   void inboxMessagesDidUpdate() {
//     setState(() {
//       debugPrint("inboxMessagesDidUpdate called");
//     });
//   }

//   void Native_Display() {
//     CleverTapPlugin.recordEvent("Native Display", {});
//   }

//   void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//     setState(() {
//       displayUnits?.forEach((element) {
//         print("Display Units = " + element.toString());
//         var img1 = element["content"][0]["icon"]["url"];
//         setState(() {
//           imageURls.add(img1);
//         });
//       });
//     });
//   }

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 CleverTapPlugin.recordEvent(
//                     "In-app Notification Triggered", {});
//               },
//               child: const Text('Push Event: In-app_1 Notification'),
//             ),
//             // Button to open the inbox
//             ElevatedButton(
//               onPressed: () {
//                 CleverTapPlugin.showInbox({});
//                 //CleverTapPlugin.recordEvent("Inbox", {});
//               },
//               child: const Text('Open Inbox'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 //CleverTapPlugin.showInbox({});
//                 CleverTapPlugin.recordEvent("Inbox", {});
//               },
//               child: const Text('Inbox Event'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 //CleverTapPlugin.showInbox({});
//                 Native_Display();
//               },
//               child: const Text('Native Display'),
//             ),
//             const SizedBox(height: 20),

//             // Display images if there are any in imageUrls
//             if (imageURls.isNotEmpty)
//               Column(
//                 children: imageURls.map((imageUrl) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Image.network(imageUrl),
//                   );
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const MyHomePage(title: 'Clevertap_Flutter_Demo'),
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
  int _counter = 0;
  List<String> imageURls = [];

  @override
  void initState() {
    super.initState();
    _initializeCleverTap();
    CleverTapPlugin.setDebugLevel(3);
  }

  void _initializeCleverTap() {
    var stuff = ["bags", "shoes"];
    var values = [DateTime.parse('20250130'), DateTime.parse('20250210')];
    CleverTapPlugin.profileSetMultiValues("End Policy Dates Multiple", values);
    var profile = {
      'Name': 'Captain America',
      'Identity': '25',
      'Email': 'chebd@america.com',
      'Phone': '+14121234',
      'stuff': stuff,
    };

    // Call CleverTap onUserLogin method with profile data
    CleverTapPlugin.onUserLogin(profile);
    CleverTapPlugin.createNotificationChannel(
        "henil123", "Flutter Test", "Flutter Test", 3, true);

    // Initialize CleverTap Inbox
    CleverTapPlugin.initializeInbox();

    // Set the CleverTap inbox did initialize handler inside initState
    CleverTapPlugin().setCleverTapInboxDidInitializeHandler(() {
      inboxDidInitialize();
    });
    CleverTapPlugin()
        .setCleverTapInboxMessagesDidUpdateHandler(inboxMessagesDidUpdate);

    // void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    //   this.setState(() {
    //     print("Display Units = " + displayUnits.toString());
    //   });
    // }

    // CleverTapPlugin()
    //     .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
    CleverTapPlugin()
        .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
  }

  void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    if (displayUnits == null || displayUnits.isEmpty) {
      debugPrint(":rotating_light: No display units received.");
      return;
    }
    debugPrint(":white_check_mark: Display Units Loaded: $displayUnits");
    setState(() {
      imageURls.clear(); // Reset previous URLs
      for (var unit in displayUnits) {
        if (unit["content"] is List && unit["content"].isNotEmpty) {
          var imgUrl = unit["content"][0]["media"]
              ?["url"]; // Use "media" instead of "icon"
          if (imgUrl != null && imgUrl.isNotEmpty) {
            imageURls.add(imgUrl);
          }
        }
      }
    });
  }

  void fetchNativeDisplay() async {
    await Future.delayed(Duration(seconds: 2)); // Ensure async wait works
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    debugPrint(":package: Manually fetched display units: $displayUnits");
    onDisplayUnitsLoaded(displayUnits);
  }

  void inboxDidInitialize() {
    setState(() {
      debugPrint(
          "inboxDidInitialize called"); // Use debugPrint instead of print
      var styleConfig = {
        'noMessageTextColor': '#ff6600', // Custom text color for "no message"
        'noMessageText':
            'No message(s) to show.', // Custom message when no inbox message is available
        'navBarTitle': 'App Inbox' // Custom title for the inbox navigation bar
      };
      // Show the inbox with the provided style configuration
      CleverTapPlugin.showInbox(styleConfig);
    });
  }

  void inboxMessagesDidUpdate() {
    setState(() {
      debugPrint("inboxMessagesDidUpdate called");
    });
  }

  void nativeDisplay() {
    debugPrint(":rocket: Triggering Native Display Event...");
    CleverTapPlugin.recordEvent("Native Display", {});
    fetchNativeDisplay(); // Manually fetch display units after triggering
  }

  // void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
  //   setState(() {
  //     displayUnits?.forEach((element) {
  //       print("Display Units = " + element.toString());
  //       var img1 = element["content"][0]["icon"]["url"];
  //       setState(() {
  //         imageURls.add(img1);
  //       });
  //     });
  //   });
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                CleverTapPlugin.recordEvent(
                    "In-app Notification Triggered", {});
              },
              child: const Text('Push Event: In-app_1 Notification'),
            ),
            // Button to open the inbox
            ElevatedButton(
              onPressed: () {
                CleverTapPlugin.showInbox({});
                //CleverTapPlugin.recordEvent("Inbox", {});
              },
              child: const Text('Open Inbox'),
            ),
            ElevatedButton(
              onPressed: () {
                //CleverTapPlugin.showInbox({});
                CleverTapPlugin.recordEvent("Inbox", {});
              },
              child: const Text('Inbox Event'),
            ),
            ElevatedButton(
              onPressed: () {
                //CleverTapPlugin.showInbox({});
                nativeDisplay();
              },
              child: const Text('Native Display'),
            ),

            // Add space between buttons and images
            const SizedBox(height: 20),

            // Display images if there are any in imageUrls
            if (imageURls.isNotEmpty)
              Column(
                children: imageURls.map((imageUrl) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(imageUrl),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
