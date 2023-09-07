import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_read_sms/flutter_read_sms.dart';
import 'package:flutter_read_sms/flutter_read_sms_platform_interface.dart';
import 'package:flutter_read_sms/flutter_read_sms_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterReadSmsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterReadSmsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterReadSmsPlatform initialPlatform = FlutterReadSmsPlatform.instance;

  test('$MethodChannelFlutterReadSms is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterReadSms>());
  });

  test('getPlatformVersion', () async {
    FlutterReadSms flutterReadSmsPlugin = FlutterReadSms();
    MockFlutterReadSmsPlatform fakePlatform = MockFlutterReadSmsPlatform();
    FlutterReadSmsPlatform.instance = fakePlatform;

    expect(await flutterReadSmsPlugin.getPlatformVersion(), '42');
  });
}
