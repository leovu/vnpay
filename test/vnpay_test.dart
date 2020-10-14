import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vnpay/vnpay.dart';

void main() {
  const MethodChannel channel = MethodChannel('vnpay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VnPay.payment, '42');
  });
}
