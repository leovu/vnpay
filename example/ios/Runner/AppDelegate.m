#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <vnpay/VnpayPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// Bổ sung
// Nếu từ web gọi redirect theo url sampleapp://backapp
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {

    NSString *encoded = [url absoluteString];
    NSString *unencodedUrlString = [encoded     stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLHostAllowedCharacterSet]];
            NSLog(@"decodedString %@", unencodedUrlString);
    NSString *scheme = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"vnpay_app_scheme"];
    NSString *sch = [NSString stringWithFormat:@"%@%@",scheme,@"://"];
    NSString *actionString=[unencodedUrlString stringByReplacingOccurrencesOfString:sch withString:@""];
    if ([@"backapp" isEqualToString:actionString]) {
        //Xử lý tại đây
        [VnpayPlugin paymentCallbackAppDelegate];
    }
    return YES;
}
@end
