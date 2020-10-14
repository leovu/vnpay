# vnpay

A new flutter plugin project.

## Getting Started

Plugin has 2 branch: release and developer for Android.

Using dev mode: 
 
     >  vnpay:
           git:
             url: https://github.com/leovu/vnpay.git
             ref: developer

Using product mode:
 
     > vnpay:
           git:
             url: https://github.com/leovu/vnpay.git
             ref: release
             

** In Android ** :
 
     > <activity
            android:name="wao.flutter.application.project.vnpay.ResultActivity" android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.VIEW"/>
                <category android:name="android.intent.category.BROWSABLE"/>
                <category android:name="android.intent.category.DEFAULT"/>
                <data android:scheme="sampleapp"/>
            </intent-filter> </activity>
    
 Add these line to Manifest. 
 
 
 
 ** In iOS** :
 
 You need to add image of back icon (file png or jpeg), if use using it by adding via Xcode.
 
 Add these line into AppDelegate
 
     > - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
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
 
 
 Add into Info.Plist 
 
     > <key>CFBundleURLTypes</key>
        <array>
          <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
              <string>sampleapp</string>
            </array>
          </dict>
        </array>
        <key>NSAppTransportSecurity</key>
        <dict>
          <key>NSAllowsArbitraryLoads</key>
          <true/>
        </dict>
