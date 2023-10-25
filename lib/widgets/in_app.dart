// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   Future initailize() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('got a message');
//       print('message data:${message.data}');
//       if (message.notification != null) {
//         print('message contain notification:${message.notification}');
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('new message published');
//       print('messager datz:${message.data}');
//     });
//   }

//   Future<String?> getDeviceToken() async {
//     return await _fcm.getToken();
//   }
// }
