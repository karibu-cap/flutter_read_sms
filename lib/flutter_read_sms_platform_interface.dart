import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_read_sms_method_channel.dart';
import 'models/sms.dart';

abstract class FlutterReadSmsPlatform extends PlatformInterface {
  /// Constructs a FlutterReadSmsPlatform.
  FlutterReadSmsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterReadSmsPlatform _instance = MethodChannelFlutterReadSms();

  /// The default instance of [FlutterReadSmsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterReadSms].
  static FlutterReadSmsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterReadSmsPlatform] when
  /// they register themselves.
  static set instance(FlutterReadSmsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<SMS> get streamIncomingSms => 
    throw UnimplementedError('streamIncomingSms() has not been implemented.');
  

  void initStreamIncomingSms() {
    throw UnimplementedError('initStreamIncomingSms() has not been implemented.');
  }
}
