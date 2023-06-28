import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:send_remider_to_user/ui/my_app.dart';
import 'package:send_remider_to_user/utils/routes/routes.dart';
import 'package:cloud_functions/cloud_functions.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title: ${message.notification?.title}");
  log("Body: ${message.notification?.body}");
  log("Payload: ${message.data}");
}

final HttpsCallable scheduleNotification =
    FirebaseFunctions.instance.httpsCallable('scheduleNotification');

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  AndroidNotificationChannel channel =
      const AndroidNotificationChannel("your_channel_id", "your_channel_name");

  /// to recive notification in foreground
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    "your_channel_id",
    "your_channel_name",
    channelDescription: "your_channel_description",
    importance: Importance.high,
    playSound: true,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: ${fcmToken.toString()}");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotificaiton();
    initLocalNotifications();
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    // push here to notifications screen if there is one
    navigatorKey.currentState!
        .pushNamed(Routes.todoListScreen, arguments: message);
  }

  /// for ios
  Future<void> initPushNotificaiton() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        1,
        notification.title,
        notification.body,
        NotificationDetails(
          android: androidPlatformChannelSpecifics,
        ),
      );
    });
  }

  Future<void> initLocalNotifications() async {
    _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> sendScheduledNotification({
    required String token,
    required String notificationTitle,
    required String notificationBody,
    required DateTime sendTime,
  }) async {
    final timestamp = sendTime.millisecondsSinceEpoch;

    try {
      await scheduleNotification.call(<String, dynamic>{
        'token': token,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'timestamp': timestamp,
      });
      log('Notification scheduled successfully.');
    } catch (e) {
      log('Error scheduling notification: $e');
    }
  }
}
