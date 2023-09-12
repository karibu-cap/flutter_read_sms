import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_read_sms_platform_interface.dart';
import 'models/sms.dart';

/// An implementation of [FlutterReadSmsPlatform] that uses method channels.
class MethodChannelFlutterReadSms extends FlutterReadSmsPlatform {
  /// Event channel used for setting up the stream to receive
  /// sms continously
  static const _channel = EventChannel("stream_incoming_sms");
  late final StreamSubscription _channelStreamSubscription;

  final StreamController _controller = StreamController<SMS>();

  /// The stream containing sms as [SMS] objects
  @override
  Stream<SMS> get streamIncomingSms => _controller.stream as Stream<SMS>;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_read_sms');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Listens to the broadcast stream exposed by the event
  /// channel and adds [SMS] on the [smsStream] whenever
  /// sms is received
  @override
  void initStreamIncomingSms() {
    _channelStreamSubscription = _channel.receiveBroadcastStream().listen((e) {
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv $e');
      if (!_controller.isClosed) {
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkk $e');
        _controller.sink.add(SMS.fromJson(e));
      }
    });
  }

  /// dispose method.
  void dispose() {
    _controller.close();
    _channelStreamSubscription.cancel();
  }
}
