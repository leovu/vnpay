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
                  scheme: "retailpro",
                  appBackAlert: "Bạn có chắc chắn trở lại ko?",
                  url:"http://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Version=2.0.0&vnp_TmnCode=DMSPRO01&vnp_Amount=440000&vnp_Command=pay&vnp_CreateDate=20201125152527&vnp_CurrCode=VND&vnp_IpAddr=52.187.52.110&vnp_Locale=vn&vnp_OrderInfo=Thanh+toan+don+hang+C000081.201125.12&vnp_OrderType=100000&vnp_ReturnUrl=https%3A%2F%2Frtqc-api-mgt.azure-api.net%2Fbrandapi%2Fa3be4081-dae7-4420-8ca5-bdad99e2b91f%2Fpayment%2Freturn&vnp_TxnRef=215&vnp_SecureHashType=SHA256&vnp_SecureHash=e27243b4fc7836ba33f3c3fffaed8352b06bd3fc18eddd8bb3dfea92c54f2c99",
                  title: "Thanh toán",
                  backIcon: "ion_back",
                  beginColor: "F06744",
                  endColor: "E26F2C",
                  titleColor: "FFFFFF",
                  tmn_code: "DMSPRO01");
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
