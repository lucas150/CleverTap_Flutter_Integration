import 'package:flutter/material.dart';
import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'dart:convert';
import 'second_screen.dart';
import 'dart:io';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("clevertap _firebaseBackgroundMessageHandler Background");

   if (message.data.containsKey('wzrk_id')) {
    print('wzrk_id is present: ${message.data['wzrk_id']}');
    CleverTapPlugin.createNotification(jsonEncode(message.data));
  } else {
    print('wzrk_id is NOT present');
  }
}

void _firebaseForegroundMessageHandler(RemoteMessage remoteMessage) {
  debugPrint('clevertap _firebaseForegroundMessageHandler called');
   if (remoteMessage.data.containsKey('wzrk_id')) {
    print('wzrk_id is present: ${remoteMessage.data['wzrk_id']}');
      CleverTapPlugin.createNotification(jsonEncode(remoteMessage.data));
  } else {
    print('wzrk_id is NOT present');
  }

  
}




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onMessage.listen(_firebaseForegroundMessageHandler);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  
  runApp(const MyApp());
}






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
  List<String> imageUrls1 = [];
  List<String> imageUrls2 = [];
   void _handleKilledStateNotificationInteraction() async {
    CleverTapAppLaunchNotification appLaunchNotification = await CleverTapPlugin.getAppLaunchNotification();
    print("_handleKilledStateNotificationInteraction => $appLaunchNotification");
    if (appLaunchNotification.didNotificationLaunchApp) {
      Map<String, dynamic> notificationPayload = appLaunchNotification.payload!;
      print("Notification Foreground 4");
      _handleDeeplink(notificationPayload);
    }
  }
  void _handleDeeplink(Map<String, dynamic> notificationPayload) {
    var type = notificationPayload["type"];
    // print("Notification Foreground 5");
    // print(type);
    debugPrint("CleverTap : payload $notificationPayload");
    if (type != null) {
      print("_handleKilledStateNotificationInteraction => Type: $type");
      print("Notification Foreground 3");

         navigatorKey.currentState?.pushNamed('/second');
      
    }
  }


  @override
  void initState() {
    super.initState();
    _initializeCleverTap();
    _setupFirebaseMessaging();
     if (Platform.isAndroid) {
      _handleKilledStateNotificationInteraction();
    }
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
      'Identity': '167267',
      'Email': 'captain@america.com',
      'Phone': '+14121234',
      'stuff': ["bags", "shoes"],
      'Customer':'Silver', 
    });


    CleverTapPlugin.createNotificationChannel("henil123", "Flutter Test", "Flutter Test", 3, true);
    CleverTapPlugin.initializeInbox();
    CleverTapPlugin().setCleverTapInboxDidInitializeHandler(() => debugPrint("✅ CleverTap Inbox Initialized"));
    CleverTapPlugin().setCleverTapInboxMessagesDidUpdateHandler(() => debugPrint("Inbox messages updated"));
    CleverTapPlugin().setCleverTapDisplayUnitsLoadedHandler(_onDisplayUnitsLoaded);
    CleverTapPlugin().setCleverTapPushClickedPayloadReceivedHandler(_onNotificationClicked);
   


    // CleverTapPlugin().recordEvent("hi",{});
  }

 

  void _onNotificationClicked(Map<String, dynamic> payload) {
    debugPrint("CleverTap Notification clicked in foreground : $payload");

    if (payload.containsKey("wzrk_dl") && payload["wzrk_dl"] == "myapp://second") {
      // print("Notification Foreground 4");

      navigatorKey.currentState?.pushNamed('/second');
    }
  }


  void _fetchNativeDisplay() async {
    CleverTapPlugin.recordEvent("Native Display", {});
    await Future.delayed(const Duration(seconds: 2));
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    _onDisplayUnitsLoaded1(displayUnits);
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

  void _fetchNativeDisplay2() async {
    // CleverTapPlugin.recordEvent("ct-nativedisplay", {});
    await Future.delayed(const Duration(seconds: 2));
    var displayUnits = await CleverTapPlugin.getAllDisplayUnits();
    _onDisplayUnitsLoaded2(displayUnits);
  }

   void _onDisplayUnitsLoaded2(List<dynamic>? displayUnits) {
    if (displayUnits == null || displayUnits.isEmpty) return;
    setState(() {
      imageUrls2 = displayUnits
          .where((unit) => unit["custom_kv"]?["id"] == "native3") 
          .expand((unit) => unit["content"])
          .map((content) => content["media"]?["url"])
          .whereType<String>()
          .toList();
    });
  }

  void _onDisplayUnitsLoaded(List<dynamic>? displayUnits) {
    debugPrint(displayUnits.toString());

    if (displayUnits == null || displayUnits.isEmpty) return;
    _onDisplayUnitsLoaded1(displayUnits);
    _onDisplayUnitsLoaded2(displayUnits);
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            ElevatedButton(
            onPressed: () async {
                var customer = await CleverTapPlugin.profileGetProperty("Customer"); // Wait for result
                debugPrint("Clevertap  ${customer ?? 'Not Found'}"); // Print value
              },              
              child: const Text('Fetch '),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => CleverTapPlugin.showInbox({}),
              child: const Text('Open Inbox'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => CleverTapPlugin.recordEvent("Inbox", {}),
              child: const Text('Inbox Event'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchNativeDisplay,
              child: const Text('Native Display'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchNativeDisplay2,
              child: const Text('ct-nativedisplay'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => navigatorKey.currentState?.pushNamed('/second'),
              child: const Text('Go to Second Page'),
            ),
            const SizedBox(height: 20),
            if (imageUrls1.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Native Display 1 Slider", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    itemCount: imageUrls1.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.network(imageUrls1[index], fit: BoxFit.contain),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (imageUrls2.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Native Display 2 Images", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  ...imageUrls2.map((url) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image.network(url, height: 200, fit: BoxFit.contain),
                      )),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
