#import "VnpayPlugin.h"
#import <CallAppSDK/CallAppInterface.h>

@implementation VnpayPlugin
FlutterResult vnPayResult;
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter.io/vnpay"
            binaryMessenger:[registrar messenger]];
  VnpayPlugin* instance = [[VnpayPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"vnpay" isEqualToString:call.method]) {
    vnPayResult = result;
    [self paymentAction:call.arguments];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

+(void)paymentCallbackAppDelegate {
    vnPayResult(-1);
}

-(void)paymentAction:(NSDictionary<NSString *, NSString *>*) dict{
    /**
     - Các tham số:
     1. URL: lấy từ hệ thống VD: https://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder
     2. Title của màn hình chọn phương thức thanh toán: VD: "Thanh toán"
     3. iconBackName của màn hình thanh toán:  VD: ion_back
     4: beginColor: Màu bắt đầu của header:  VD: F06744
     5: endColor: Màu kết thúc của header:  VD: E26F2C
     6. tmnCode: VD: 2QXUI4J4
     7: titleColor: Màu của header title
     +(void)setAppBackAlert:(NSString*)alert;//Default: @"Bạn có chắc chắn muốn trở lại không?"
     +(void)setAppNotAvailableAlert:(NSString*)alert;//Default: @"Thiết bị chưa cài đặt ứng dụng thanh toán này, bạn có muốn cài đặt không?"
     7. [CallAppInterface setSchemes:@"sampleApp"];  Hàm set schemes của app để ứng dụng MB gọi quay trở lại khi thanh toán xong. Tham số này set trong URL Types của ứng dụng
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sdkAction:) name:@"SDK_COMPLETED" object:nil];
    bool isSandbox = [dict[@"isSandbox"]  isEqual: @"true"] ? true : false;
    [CallAppInterface setSchemes:dict[@"scheme"]];

    [[NSUserDefaults standardUserDefaults] setObject:dict[@"scheme"] forKey:@"vnpay_app_scheme"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [CallAppInterface setIsSandbox:isSandbox];
    [CallAppInterface setAppBackAlert:dict[@"appBackAlert"]];
    [CallAppInterface setHomeViewController:[[UIApplication sharedApplication] delegate].window.rootViewController];
    [CallAppInterface showPushPaymentwithPaymentURL:dict[@"url"] withTitle:dict[@"title"] iconBackName:dict[@"backIcon"] beginColor:dict[@"beginColor"] endColor:dict[@"endColor"] titleColor:dict[@"titleColor"] tmn_code:dict[@"tmnCode"]];
}


-(void)sdkAction:(NSNotification *)notification{
    // Khi SKD xử lý xong, sẽ gọi ở hàm này(Bao gồm, cả người dùng nhấn back, và thanh toán thành công)
    if ([notification.name isEqualToString:@"SDK_COMPLETED"]) {
        NSLog(@"Notify Value: %@",notification.object);
        NSString *actionValue=[notification.object valueForKey:@"Action"];
        if ([@"AppBackAction" isEqualToString:actionValue]) {
            vnPayResult(-1);
        }
        if ([@"WebBackAction" isEqualToString:actionValue]) {
            vnPayResult(1);
        }
        if ([@"FaildBackAction" isEqualToString:actionValue]) {
            vnPayResult(1);
        }
        if ([@"SuccessBackAction" isEqualToString:actionValue]) {
            vnPayResult(1);
        }
        if ([@"CallMobileBankingApp" isEqualToString:actionValue]) {
            vnPayResult(0);
        }
    }
}

@end
