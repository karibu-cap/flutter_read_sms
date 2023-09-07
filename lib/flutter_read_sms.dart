
import 'flutter_read_sms_platform_interface.dart';

class FlutterReadSms {
  Future<String?> getPlatformVersion() {
    return FlutterReadSmsPlatform.instance.getPlatformVersion();
  }
}
