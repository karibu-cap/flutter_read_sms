
import 'flutter_read_sms_platform_interface.dart';
import 'models/sms.dart';

class FlutterReadSms {
  Future<String?> getPlatformVersion() {
    return FlutterReadSmsPlatform.instance.getPlatformVersion();
  }
  
  Stream<SMS> get streamIncomingSms =>
    FlutterReadSmsPlatform.instance.streamIncomingSms as Stream<SMS>;
  
  
  void initStreamIncomingSms() {
     FlutterReadSmsPlatform.instance.initStreamIncomingSms();
  }
}
