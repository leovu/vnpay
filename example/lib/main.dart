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
                  url:"http:\/\/sandbox.vnpayment.vn\/paymentv2\/vpcpay.html?vnp_Version=2.0.0&vnp_TmnCode=DMSPRO01&vnp_Amount=11000000&vnp_Command=pay&vnp_CreateDate=20201124124945&vnp_CurrCode=VND&vnp_IpAddr=52.187.53.238&vnp_Locale=vn&vnp_OrderInfo=Thanh+toan+don+hang+C000081.201124.16&vnp_OrderType=100000&vnp_ReturnUrl=https%3A%2F%2Frtqc-api-mgt.azure-api.net%2Fbrandapi%2Fa3be4081-dae7-4420-8ca5-bdad99e2b91f%2Fpayment%2Freturn&vnp_TxnRef=169&vnp_SecureHashType=SHA256&vnp_SecureHash=2642181bf5ef5632316d78390b24f3381f182ef14296c317435b3baa46047f2a",
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
