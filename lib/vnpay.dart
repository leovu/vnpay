import 'dart:async';

import 'package:flutter/services.dart';

class VnPay {
  static const MethodChannel _channel = const MethodChannel('flutter.io/vnpay');
  static Future<VnPayResult> payment({
    bool isSandbox,
    String scheme,
    String appBackAlert,
    String url,
    String title,
    String backIcon,
    String beginColor,
    String endColor,
    String titleColor,
    String tmnCode,
  }) async {
    Map<String, String> dict = {
      "isSandbox": (isSandbox ?? false).toString(),
      "scheme": scheme ?? "",
      "appBackAlert": appBackAlert ?? "",
      "url": url ?? "",
      "title": title ?? "",
      "backIcon": backIcon ?? "",
      "beginColor": beginColor ?? "",
      "endColor": endColor ?? "",
      "titleColor": titleColor ?? "",
      "tmnCode": tmnCode ?? "",
    };
    final int result = await _channel.invokeMethod('vnpay', dict);
    if(result == 1){
      return VnPayResult.SUCCESS;
    }
    else if(result == 0){
      return VnPayResult.PROCESSING;
    }

    return VnPayResult.CANCEL;
  }
}

enum VnPayResult{SUCCESS, PROCESSING, CANCEL}