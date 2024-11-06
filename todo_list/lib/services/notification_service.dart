// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notificationsPlugin.initialize(settings);
  }

  Future<void> scheduleNotification(
      String id, String title, String description, DateTime deadline) async {
    if (deadline.isBefore(DateTime.now())) return;

    final scheduledDate = deadline.subtract(const Duration(minutes: 10));

    // If scheduled time is in the past (deadline < 10 mins away)
    if (scheduledDate.isBefore(DateTime.now())) {
      // Show immediate notification instead
      await notificationsPlugin.show(
        id.hashCode,
        'Reminder: $title',
        'Tasks to be submitted in under 10 minutes',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'todo_reminder',
            'TODO Reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
      return;
    }

    // Normal scheduling for deadlines >10 mins away
    await notificationsPlugin.zonedSchedule(
      id.hashCode,
      'Reminder: $title',
      'Task due in 10 minutes',
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'todo_reminder',
          'TODO Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(String id) async {
    await notificationsPlugin.cancel(id.hashCode);
  }
}
