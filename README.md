# vnpay

A new flutter plugin project.

## Getting Started

Plugin has 2 branch: release and developer for Android.

How to use :

     >  String result = await VnPay.payment(
                isSandbox: "true",
                scheme: "sampleapp",
                appBackAlert: "Bạn có chắc chắn trở lại ko?",
                url:
                    "http",
                title: "Thanh toán",
                backIcon: "ion_back",
                beginColor: "F06744",
                endColor: "E26F2C",
                titleColor: "FFFFFF",
                tmn_code: "DMSPRO01",
              );

Result: 
"AppBackAction", "backapp" : back from button (cancel)
"WebBackAction" , "CallMobileBankingApp" : back from after transaction 

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
 
     >  <activity android:name="wao.flutter.application.project.vnpay.ResultActivity"
            android:parentActivityName="wao.flutter.application.project.vnpay.StartActivity"
            android:theme="@style/noAnimTheme">
            <intent-filter>
                <action android:name="android.intent.action.VIEW"/>
                <category android:name="android.intent.category.BROWSABLE"/>
                <category android:name="android.intent.category.DEFAULT"/>
                <data android:scheme="retailpro"/>
            </intent-filter>
            <meta-data
                android:name="android.support.PARENT_ACTIVITY"
                android:value="wao.flutter.application.project.vnpay.StartActivity"/>
        </activity>
        <activity
            android:name="wao.flutter.application.project.vnpay.StartActivity"
            android:parentActivityName=".SplashActivity"
            android:theme="@style/noAnimTheme">
        </activity>
        <activity
            android:name=".SplashActivity"
            android:parentActivityName=".MainActivity"
            android:theme="@style/noAnimTheme">
        </activity>
 
 Create SplashAcitivty in app project 
 
     import android.app.Activity;
     import android.os.Bundle;
     import android.os.Handler;

     import androidx.annotation.Nullable;

      public class SplashActivity extends Activity {
         @Override
         protected void onCreate(@Nullable Bundle savedInstanceState) {
             super.onCreate(savedInstanceState);
             setContentView(R.layout.splash_activity);
             Handler handler = new Handler();
             handler.postDelayed(new Runnable() {
                 public void run() {
                     UtilProject.INSTANCE.setVnpayOpen(true);
                     finish();
                 }
             }, 500);
         }

       }

 Add the UtilProject and add MainActivity 
 
           override fun onCreate(savedInstanceState: Bundle?) {
                  super.onCreate(savedInstanceState)
                  if (UtilProject.vnpayOpen) {
                      finish()
                      UtilProject.vnpayOpen = false
                  }
              }
          object UtilProject {
            var vnpayOpen:Boolean = false
            var webViewUrl: String = ""
            var pendingResult: MethodChannel.Result? = null
          }
          

    
 Add these line to Manifest. 
 
 And in the res/style : 
         
     >  <style name="noAnimTheme" parent="android:Theme">
        <item name="android:windowAnimationStyle">@null</item>
        </style>
 
 
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
