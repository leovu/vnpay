import 'dart:async';

import 'package:flutter/services.dart';

class VnPay {
  static const MethodChannel _channel = const MethodChannel('flutter.io/vnpay');
  static Future<String> payment({
    String isSandbox,
    String scheme,
    String appBackAlert,
    String url,
    String title,
    String backIcon,
    String beginColor,
    String endColor,
    String titleColor,
    String tmn_code,
  }) async {
    Map<String, String> dict = {
      "isSandbox": isSandbox ?? "false",
      "scheme": scheme ?? "",
      "appBackAlert": appBackAlert ?? "",
      "url": url ?? "",
      "title": title ?? "",
      "backIcon": backIcon ?? "",
      "beginColor": beginColor ?? "",
      "endColor": endColor ?? "",
      "titleColor": titleColor ?? "",
      "tmn_code": tmn_code ?? "",
    };
    final String result = await _channel.invokeMethod('vnpay', dict);
    return result;
  }
}
