import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_read_sms_platform_interface.dart';

/// An implementation of [FlutterReadSmsPlatform] that uses method channels.
class MethodChannelFlutterReadSms extends FlutterReadSmsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_read_sms');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
