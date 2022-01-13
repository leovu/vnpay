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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SDK_COMPLETED"
    object:Nil];
}

-(void)paymentAction:(NSDictionary<NSString *, NSString *>*) dict{
    UIViewController *fromVC = [[UIApplication sharedApplication] delegate].window.rootViewController; //bắt buộc
    NSString *scheme = dict[@"scheme"]; //bắt buộc, tên scheme merchant tự cài đặt theo app
    BOOL isSandbox = [dict[@"isSandbox"]  isEqual: @"true"] ? true : false; //bắt buộc, YES <=> môi trường test, NO <=> môi trường live
    NSString *paymentUrl = dict[@"url"]; //bắt buộc, URL hệ thống Merchant tạo.
    NSString *tmn_code = dict[@"tmnCode"]; //bắt buộc, VNPAY cung cấp
    BOOL backAction = YES; //bắt buộc, YES <=> bấm back sẽ thoát SDK, NO <=> bấm back thì trang web sẽ back lại trang trước đó, nên set là YES, nên set là YES, vì trang thanh toán không nên cho người dùng back về trang trước
    NSString *backAlert = dict[@"appBackAlert"]; //không bắt buộc, thông báo khi người dùng bấm back
    NSString *title = dict[@"title"]; //bắt buộc, title của trang thanh toán
    NSString *titleColor = dict[@"titleColor"]; //bắt buộc, màu của title
    NSString *beginColor = dict[@"beginColor"]; //bắt buộc, màu của background title
    NSString *endColor = dict[@"endColor"]; //bắt buộc, màu của background title
    NSString *iconBackName = dict[@"backIcon"]; //bắt buộc, icon back
    
    [self showFromVC:fromVC
              scheme:scheme
           isSandbox:isSandbox
          paymentUrl:paymentUrl
            tmn_code:tmn_code
          backAction:backAction
           backAlert:backAlert
               title:title
          titleColor:titleColor
          beginColor:beginColor
            endColor:endColor
        iconBackName:iconBackName];
}

- (void)showFromVC:(UIViewController*)fromVC
            scheme:(NSString *)scheme
         isSandbox:(BOOL )isSandbox
        paymentUrl:(NSString *)paymentUrl
          tmn_code:(NSString *)tmn_code
        backAction:(BOOL)backAction
         backAlert:(NSString *)backAlert
             title:(NSString *)title
        titleColor:(NSString *)titleColor
        beginColor:(NSString *)beginColor
          endColor:(NSString *)endColor
      iconBackName:(NSString *)iconBackName {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SDK_COMPLETED" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sdkAction:) name:@"SDK_COMPLETED" object:nil];
    [CallAppInterface setHomeViewController:fromVC];
    [CallAppInterface setSchemes:scheme];
    [CallAppInterface setIsSandbox:isSandbox];
    [CallAppInterface setAppBackAlert:backAlert];
    [CallAppInterface setEnableBackAction:backAction];
    [CallAppInterface showPushPaymentwithPaymentURL:paymentUrl
                                          withTitle:title
                                       iconBackName:iconBackName
                                          beginColor:beginColor
                                           endColor:endColor
                                          titleColor:titleColor
                                           tmn_code:tmn_code];
}


-(void)sdkAction:(NSNotification*)notification {
    if ([notification.name isEqualToString:@"SDK_COMPLETED"]){
        NSString *actionValue=[notification.object valueForKey:@"Action"];
        //Người dùng nhấn back từ sdk để quay lại
        if ([@"AppBackAction" isEqualToString:actionValue]) {
            vnPayResult(@(-1));
        }
        //Kiểm tra mã lỗi thanh toán VNPAY phản hồi trên Return URL. Từ Return URL của đơn vị kết nối thực hiện chuyển hướng đi URL: http://cancel.sdk.merchantbackapp
        if ([@"WebBackAction" isEqualToString:actionValue]) {
            vnPayResult(@(1));
        }
        //Kiểm tra mã lỗi thanh toán VNPAY phản hồi trên Return URL. Từ Return URL của đơn vị kết nối thực hiện chuyển hướng đi URL: http://fail.sdk.merchantbackapp
        if ([@"FaildBackAction" isEqualToString:actionValue]) {
            vnPayResult(@(1));
        }
        //Kiểm tra mã lỗi thanh toán VNPAY phản hồi trên Return URL. Từ Return URL của đơn vị kết nối thực hiện chuyển hướng đi URL: http://success.sdk.merchantbackapp
        if ([@"SuccessBackAction" isEqualToString:actionValue]) {
            vnPayResult(@(1));
        }
        //Người dùng nhấn chọn thanh toán qua app thanh toán (Mobile Banking, Ví...)
        if ([@"CallMobileBankingApp" isEqualToString:actionValue]) {
            vnPayResult(@(0));
        }
    }
}

@end
