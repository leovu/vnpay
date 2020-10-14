import 'package:flutter/material.dart';
import 'package:vnpay/vnpay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = 'Click';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Center(
              child: MaterialButton(
            child: Text('Vnpay: $_result\n'),
            onPressed: () async {
              String result = await VnPay.payment(
                isSandbox: "true",
                scheme: "sampleapp",
                appBackAlert: "Bạn có chắc chắn trở lại ko?",
                url:
                    "http://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1000000&vnp_Command=pay&vnp_CreateDate=20201014105120&vnp_CurrCode=VND&vnp_IpAddr=104.215.155.1&vnp_Locale=vn&vnp_OrderInfo=Thanh+to%C3%A1n+%C4%91%C6%A1n+h%C3%A0ng+123&vnp_OrderType=100000&vnp_ReturnUrl=http%3A%2F%2F138.91.43.149%2Fb6e9d857-ee21-4bf2-b4e3-e76d41a2500b%2Fpayment%2Freturn&vnp_TmnCode=DMSPRO01&vnp_TxnRef=5f8675b8f39c1&vnp_Version=2.0.0&vnp_SecureHashType=SHA256&vnp_SecureHash=db6a3a984409fdd548339acac76a6dac3ac9269499d1a970a9fd2212c108fe83",
                title: "Thanh toán",
                backIcon: "ion_back",
                beginColor: "F06744",
                endColor: "E26F2C",
                titleColor: "FFFFFF",
                tmn_code: "DMSPRO01",
              );
              setState(() {
                _result = result;
              });
            },
          )),
        ),
      ),
    );
  }
}
