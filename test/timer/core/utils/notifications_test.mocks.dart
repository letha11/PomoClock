// Mocks generated by Mockito 5.4.2 from annotations
// in pomodoro_timer/test/timer/core/utils/notifications_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_local_notifications/src/flutter_local_notifications_plugin.dart'
    as _i2;
import 'package:flutter_local_notifications/src/initialization_settings.dart'
    as _i4;
import 'package:flutter_local_notifications/src/notification_details.dart'
    as _i6;
import 'package:flutter_local_notifications/src/platform_specifics/android/schedule_mode.dart'
    as _i9;
import 'package:flutter_local_notifications/src/platform_specifics/ios/enums.dart'
    as _i8;
import 'package:flutter_local_notifications/src/types.dart' as _i10;
import 'package:flutter_local_notifications_platform_interface/flutter_local_notifications_platform_interface.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:timezone/timezone.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FlutterLocalNotificationsPlugin].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterLocalNotificationsPlugin extends _i1.Mock
    implements _i2.FlutterLocalNotificationsPlugin {
  @override
  _i3.Future<bool?> initialize(
    _i4.InitializationSettings? initializationSettings, {
    _i5.DidReceiveNotificationResponseCallback?
        onDidReceiveNotificationResponse,
    _i5.DidReceiveBackgroundNotificationResponseCallback?
        onDidReceiveBackgroundNotificationResponse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [initializationSettings],
          {
            #onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
            #onDidReceiveBackgroundNotificationResponse:
                onDidReceiveBackgroundNotificationResponse,
          },
        ),
        returnValue: _i3.Future<bool?>.value(),
        returnValueForMissingStub: _i3.Future<bool?>.value(),
      ) as _i3.Future<bool?>);

  @override
  _i3.Future<_i5.NotificationAppLaunchDetails?>
      getNotificationAppLaunchDetails() => (super.noSuchMethod(
            Invocation.method(
              #getNotificationAppLaunchDetails,
              [],
            ),
            returnValue: _i3.Future<_i5.NotificationAppLaunchDetails?>.value(),
            returnValueForMissingStub:
                _i3.Future<_i5.NotificationAppLaunchDetails?>.value(),
          ) as _i3.Future<_i5.NotificationAppLaunchDetails?>);

  @override
  _i3.Future<void> show(
    int? id,
    String? title,
    String? body,
    _i6.NotificationDetails? notificationDetails, {
    String? payload,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #show,
          [
            id,
            title,
            body,
            notificationDetails,
          ],
          {#payload: payload},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> cancel(
    int? id, {
    String? tag,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [id],
          {#tag: tag},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> cancelAll() => (super.noSuchMethod(
        Invocation.method(
          #cancelAll,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> zonedSchedule(
    int? id,
    String? title,
    String? body,
    _i7.TZDateTime? scheduledDate,
    _i6.NotificationDetails? notificationDetails, {
    required _i8.UILocalNotificationDateInterpretation?
        uiLocalNotificationDateInterpretation,
    bool? androidAllowWhileIdle = false,
    _i9.AndroidScheduleMode? androidScheduleMode,
    String? payload,
    _i10.DateTimeComponents? matchDateTimeComponents,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #zonedSchedule,
          [
            id,
            title,
            body,
            scheduledDate,
            notificationDetails,
          ],
          {
            #uiLocalNotificationDateInterpretation:
                uiLocalNotificationDateInterpretation,
            #androidAllowWhileIdle: androidAllowWhileIdle,
            #androidScheduleMode: androidScheduleMode,
            #payload: payload,
            #matchDateTimeComponents: matchDateTimeComponents,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> periodicallyShow(
    int? id,
    String? title,
    String? body,
    _i5.RepeatInterval? repeatInterval,
    _i6.NotificationDetails? notificationDetails, {
    String? payload,
    bool? androidAllowWhileIdle = false,
    _i9.AndroidScheduleMode? androidScheduleMode,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #periodicallyShow,
          [
            id,
            title,
            body,
            repeatInterval,
            notificationDetails,
          ],
          {
            #payload: payload,
            #androidAllowWhileIdle: androidAllowWhileIdle,
            #androidScheduleMode: androidScheduleMode,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<List<_i5.PendingNotificationRequest>>
      pendingNotificationRequests() => (super.noSuchMethod(
            Invocation.method(
              #pendingNotificationRequests,
              [],
            ),
            returnValue: _i3.Future<List<_i5.PendingNotificationRequest>>.value(
                <_i5.PendingNotificationRequest>[]),
            returnValueForMissingStub:
                _i3.Future<List<_i5.PendingNotificationRequest>>.value(
                    <_i5.PendingNotificationRequest>[]),
          ) as _i3.Future<List<_i5.PendingNotificationRequest>>);

  @override
  _i3.Future<List<_i5.ActiveNotification>> getActiveNotifications() =>
      (super.noSuchMethod(
        Invocation.method(
          #getActiveNotifications,
          [],
        ),
        returnValue: _i3.Future<List<_i5.ActiveNotification>>.value(
            <_i5.ActiveNotification>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i5.ActiveNotification>>.value(
                <_i5.ActiveNotification>[]),
      ) as _i3.Future<List<_i5.ActiveNotification>>);
}
