import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../firebase_options.dart';

final FlutterLocalNotificationsPlugin notiPlugin =
FlutterLocalNotificationsPlugin();

Future<void> cancelNotification() async {
  await notiPlugin.cancelAll();
}

Future<void> requestPermissions() async {
  await notiPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> showNotification({
  required title,
  required message,
}) async {
  notiPlugin.show(
    11,
    title,
    message,
    NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        channelDescription: "channelDescription",
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const IOSNotificationDetails(
        badgeNumber: 1,
        subtitle: 'the subtitle',
        sound: 'slow_spring_board.aiff',
      ),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  print('noti - title : ${notification?.title}, body : ${notification?.body}');
  Map<String, dynamic> data = message.data;
  await cancelNotification();
  await requestPermissions();
  await showNotification(title: data['title'], message: data['value']);
}
//..........................
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  var token = await FirebaseMessaging.instance.getToken();

  print("token:${token ?? 'token NULL!'}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      Map<String, dynamic> data = message.data;
      print('data - ${data['title']} - ${data['value']}');

      await cancelNotification();
      await requestPermissions();
      await showNotification(title: data['title'], message: data['value']);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FCM Test"),
      ),
      body: Center(
          child: Text("FCM Test", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
      ),
    );
  }
}
