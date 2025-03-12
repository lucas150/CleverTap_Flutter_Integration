// import 'package:flutter/material.dart';
// import 'package:clevertap_plugin/clevertap_plugin.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:convert';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//     FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageHandler);
//     FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);

//   runApp(const MyApp());
// }
//    Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
//     // This is a dummy firebase integration to test usecases with background isolates
//     await Firebase.initializeApp();
//     print("clevertap _firebaseBackgroundMessageHandler Background");
//     CleverTapPlugin.createNotification(jsonEncode(message.data));
//   }

//   // Handles foreground messages of FCM
//   void _firebaseForegroundMessageHandler(RemoteMessage remoteMessage) {
//     print('clevertap _firebaseForegroundMessageHandler called');
//     CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
//   }


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
//     FirebaseMessaging.instance.getToken().then((value) {
//       print("clevetap token:"+value.toString());
//       if (value != null) {
//         debugPrint(":push clevertap token ...");
//         CleverTapPlugin.setPushToken(value);
//       }
//     });
//       CleverTapPlugin cleverTap = CleverTapPlugin();

//       // CleverTapPlugin().setCleverTapPushClickedPayloadReceivedHandler(pushClickedPayloadReceived);
//         cleverTap.setCleverTapPushClickedPayloadReceivedHandler(pushClickedPayloadReceived);
      
      



//   }
//   void pushClickedPayloadReceived(Map<String, dynamic> notificationPayload) {
//   print("pushClickedPayloadReceived called with payload: ${notificationPayload.toString()}");
//         // You may perform UI operation like redirecting the user to a specific page based on custom key-value pairs
//         // passed in the notificationPayload. You may also perform non UI operation such as HTTP requests, IO with local storage etc.
//  Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SecondRoute()),
//                 );
//                       }

    
//     void _onKilledStateNotificationClickedHandler(Map<String, dynamic> map) async {
//   print("Notification Payload received: " + map.toString());
//   Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SecondRoute()),
//                 );
// }

      

//     // 🔔 Handles push notification clicks
//   // void pushClickedPayloadReceived(Map<String, dynamic> notificationPayload) {
//   //   print("📩 pushClickedPayloadReceived called with payload: $notificationPayload");
//   //   handleNotificationClick(notificationPayload);
//   // }






    





//   void _initializeCleverTap() {
//     var stuff = ["bags", "shoes"];
//     var profile = {
//       'Name': 'Captainavg America',
//       'Identity': '101',
//       'Email': 'cabdhj@america.com',
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
//       // inboxDidInitialize();
//       debugPrint("✅ CleverTap Inbox Initialized");

//     });
//     CleverTapPlugin()
//         .setCleverTapInboxMessagesDidUpdateHandler(inboxMessagesDidUpdate);

//     // void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//     //   this.setState(() {
//     //     print("Display Units = " + displayUnits.toString());
//     //   });
//     // }

//     // CleverTapPlugin()
//     //     .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
//     CleverTapPlugin()
//         .setCleverTapDisplayUnitsLoadedHandler(onDisplayUnitsLoaded);
//   }

//   void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//     if (displayUnits == null || displayUnits.isEmpty) {
//       debugPrint(":rotating_light: No display units received.");
//       return;
//     }
//     debugPrint(":white_check_mark: Display Units Loaded: $displayUnits");
//     setState(() {
//       imageURls.clear(); // Reset previous URLs
//       for (var unit in displayUnits) {
//         if (unit["content"] is List && unit["content"].isNotEmpty) {
//           var imgUrl = unit["content"][0]["media"]
//               ?["url"]; // Use "media" instead of "icon"
//           if (imgUrl != null && imgUrl.isNotEmpty) {
//             imageURls.add(imgUrl);
//           }
//         }
//       }
//     });
//   }

//   void fetchNativeDisplay() async {
//     await Future.delayed(Duration(seconds: 2)); // Ensure async wait works
//     var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
//     debugPrint(":package: Manually fetched display units: $displayUnits");
//     onDisplayUnitsLoaded(displayUnits);
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

//   void nativeDisplay() {
//     debugPrint(":rocket: Triggering Native Display Event...");
//     CleverTapPlugin.recordEvent("Native Display", {});
//     fetchNativeDisplay(); // Manually fetch display units after triggering
//   }

//   // void onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//   //   setState(() {
//   //     displayUnits?.forEach((element) {
//   //       print("Display Units = " + element.toString());
//   //       var img1 = element["content"][0]["icon"]["url"];
//   //       setState(() {
//   //         imageURls.add(img1);
//   //       });
//   //     });
//   //   });
//   // }



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
//                 nativeDisplay();
//               },
//               child: const Text('Native Display'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 //CleverTapPlugin.showInbox({});
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SecondRoute()),
//                 );
//               },
//               child: const Text('2nd Page'),
//             ),

//             // Add space between buttons and images
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
   
//     );
//   }
// }




// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Route')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate back to first route when tapped.
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:clevertap_plugin/clevertap_plugin.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'firebase_options.dart';
// import 'dart:convert';
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


// Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint("clevertap _firebaseBackgroundMessageHandler Background");
//   CleverTapPlugin.createNotification(jsonEncode(message.data));
// }

// void _firebaseForegroundMessageHandler(RemoteMessage remoteMessage) {
//   debugPrint('clevertap _firebaseForegroundMessageHandler called');
//   CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageHandler);
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
//   CleverTapPlugin.onKilledStateNotificationClicked(_onKilledStateNotificationClickedHandler);

//   runApp(const MyApp());
// }
// void _onKilledStateNotificationClickedHandler(Map<String, dynamic> payload) {
//     print("Notification clicked in Kill State : $payload");
  
//     if (payload.containsKey("wzrk_dl") && payload["wzrk_dl"] == "myapp://second") {
//         navigatorKey.currentState?.pushNamed('/second');
//     }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       title: 'CleverTap Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Clevertap Flutter Demo'),
//        routes: {
//         'myapp://second': (context) => const SecondRoute(),
//       },
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
//   List<String> imageUrls = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeCleverTap();
//     _setupFirebaseMessaging();
//   }

//   void _setupFirebaseMessaging() {
//     FirebaseMessaging.instance.getToken().then((value) {
//       if (value != null) {
//         debugPrint("CleverTap Token: $value");
//         CleverTapPlugin.setPushToken(value);
//       }
//     });
//   }

//   void _initializeCleverTap() {
//     CleverTapPlugin.onUserLogin({
//       'Name': 'Captain America',
//       'Identity': '101',
//       'Email': 'captain@america.com',
//       'Phone': '+14121234',
//       'stuff': ["bags", "shoes"],
//     });

//     CleverTapPlugin.createNotificationChannel("henil123", "Flutter Test", "Flutter Test", 3, true);
//     CleverTapPlugin.initializeInbox();
//     CleverTapPlugin().setCleverTapInboxDidInitializeHandler(() => debugPrint("✅ CleverTap Inbox Initialized"));
//     CleverTapPlugin().setCleverTapInboxMessagesDidUpdateHandler(() => debugPrint("Inbox messages updated"));
//     CleverTapPlugin().setCleverTapDisplayUnitsLoadedHandler(_onDisplayUnitsLoaded);
//     CleverTapPlugin().setCleverTapPushClickedPayloadReceivedHandler(_onNotificationClicked);
//   }

//   void _onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
//     if (displayUnits == null || displayUnits.isEmpty) return;
//     setState(() {
//       imageUrls = displayUnits
//           .where((unit) => unit["content"] is List)
//           .expand((unit) => unit["content"])
//           .map((content) => content["media"]?["url"])
//           .whereType<String>()
//           .toList();
//     });
//   }

//   void _onNotificationClicked(Map<String, dynamic> payload) {
//     print("Notification clicked in Foreground/ Background: $payload");

//     if (payload.containsKey("wzrk_dl") && payload["wzrk_dl"] == "myapp://second") {
//         Navigator.push(context, MaterialPageRoute(builder: (_) => const SecondRoute()));
//     }
//   }

  

//   void _fetchNativeDisplay() async {
//      CleverTapPlugin.recordEvent("Native Display", {});
//     await Future.delayed(const Duration(seconds: 2));
//     var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
//     _onDisplayUnitsLoaded(displayUnits);
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
//             ElevatedButton(
//               onPressed: () => CleverTapPlugin.recordEvent("In-app Notification Triggered", {}),
//               child: const Text('Trigger In-app Notification'),
//             ),
//             ElevatedButton(
//               onPressed: () => CleverTapPlugin.showInbox({}),
//               child: const Text('Open Inbox'),
//             ),
//             ElevatedButton(
//               onPressed: () => CleverTapPlugin.recordEvent("Inbox", {}),
//               child: const Text('Inbox Event'),
//             ),
//             ElevatedButton(
//               onPressed: _fetchNativeDisplay,
//               child: const Text('Native Display'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecondRoute())),
//               child: const Text('Go to Second Page'),
//             ),
//             const SizedBox(height: 20),
//             if (imageUrls.isNotEmpty)
//               Column(
//                 children: imageUrls.map((url) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Image.network(url),
//                 )).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Route')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

























import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'dart:convert';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("clevertap _firebaseBackgroundMessageHandler Background");
  CleverTapPlugin.createNotification(jsonEncode(message.data));
}

void _firebaseForegroundMessageHandler(RemoteMessage remoteMessage) {
  debugPrint('clevertap _firebaseForegroundMessageHandler called');
  CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageHandler);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  // CleverTapPlugin.onKilledStateNotificationClicked(_onKilledStateNotificationClickedHandler);

  runApp(const MyApp());
}

// @pragma('vm:entry-point')
// void _onKilledStateNotificationClickedHandler(Map<String, dynamic> payload) {
//   debugPrint("Notification clicked in Kill State: $payload");

//   if (payload.containsKey("wzrk_dl") && payload["wzrk_dl"] == "myapp://second") {
//     navigatorKey.currentState?.pushNamed('/second');
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'CleverTap Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'CleverTap Flutter Demo'),
        '/second': (context) => const SecondRoute(),
      },
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
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    _initializeCleverTap();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        debugPrint("CleverTap Token: $value");
        CleverTapPlugin.setPushToken(value);
      }
    });
  }

  void _initializeCleverTap() {
    CleverTapPlugin.onUserLogin({
      'Name': 'Captain America',
      'Identity': '101',
      'Email': 'captain@america.com',
      'Phone': '+14121234',
      'stuff': ["bags", "shoes"],
    });

    CleverTapPlugin.createNotificationChannel("henil123", "Flutter Test", "Flutter Test", 3, true);
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin().setCleverTapInboxDidInitializeHandler(() => debugPrint("✅ CleverTap Inbox Initialized"));
    CleverTapPlugin().setCleverTapInboxMessagesDidUpdateHandler(() => debugPrint("Inbox messages updated"));
    CleverTapPlugin().setCleverTapDisplayUnitsLoadedHandler(_onDisplayUnitsLoaded);
    CleverTapPlugin().setCleverTapPushClickedPayloadReceivedHandler(_onNotificationClicked);
  }

  void _onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    if (displayUnits == null || displayUnits.isEmpty) return;
    setState(() {
      imageUrls = displayUnits
          .where((unit) => unit["content"] is List)
          .expand((unit) => unit["content"])
          .map((content) => content["media"]?["url"])
          .whereType<String>()
          .toList();
    });
  }

  void _onNotificationClicked(Map<String, dynamic> payload) {
    debugPrint("Notification clicked: $payload");

    if (payload.containsKey("wzrk_dl") && payload["wzrk_dl"] == "myapp://second") {
      navigatorKey.currentState?.pushNamed('/second');
    }
  }

  void _fetchNativeDisplay() async {
    CleverTapPlugin.recordEvent("Native Display", {});
    await Future.delayed(const Duration(seconds: 2));
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    _onDisplayUnitsLoaded(displayUnits);
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
            ElevatedButton(
              onPressed: () => CleverTapPlugin.recordEvent("In-app Notification Triggered", {}),
              child: const Text('Trigger In-app Notification'),
            ),
            ElevatedButton(
              onPressed: () => CleverTapPlugin.showInbox({}),
              child: const Text('Open Inbox'),
            ),
            ElevatedButton(
              onPressed: () => CleverTapPlugin.recordEvent("Inbox", {}),
              child: const Text('Inbox Event'),
            ),
            ElevatedButton(
              onPressed: _fetchNativeDisplay,
              child: const Text('Native Display'),
            ),
            ElevatedButton(
              onPressed: () => navigatorKey.currentState?.pushNamed('/second'),
              child: const Text('Go to Second Page'),
            ),
            const SizedBox(height: 20),
            if (imageUrls.isNotEmpty)
              Column(
                children: imageUrls.map((url) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(url),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
          child: const Text('Go Home'),
        ),
      ),
    );
  }
}
