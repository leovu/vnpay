# vnpay

A new flutter plugin project.

## Getting Started

Plugin has 2 branch: release and developer for Android.

How to use :

     >  VnPayResult result = await VnPay.payment(
                isSandbox: true,
                scheme: "sampleapp",
                appBackAlert: "Bạn có chắc chắn trở lại ko?",
                url: "http",
                title: "Thanh toán",
                backIcon: "ion_back",
                beginColor: "000000",
                endColor: "000000",
                titleColor: "FFFFFF",
                tmnCode: "TMNCODE",
              );

Result: 
SUCCESS : successful payment operation
PROCESSING : paying on vnpay wallet app
CANCEL : cancel payment

Using: 
 
     >  vnpay:
           git:
             url: https://github.com/leovu/vnpay.git
             ref: v2
             

** In Android ** :
 
     >  <activity android:name="wao.flutter.application.project.vnpay.ResultActivity"
          android:exported="false">
      <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <data android:scheme="sampleapp" />
      </intent-filter>
    </activity>
    
    
 Add ':vnpay' to the first line of file android/settings.gradle
 
     > include ':app', ':vnpay'
     
     
 Add this line to the dependencies section of the file android/app/build.gradle
 
     > implementation project(':vnpay')
 
 
 ** In iOS** :
 
 You need to add image of back icon (file png or jpeg), if use using it by adding via Xcode.
 
 Add these line into AppDelegate
 
     > override func application(
          _ application: UIApplication,
          open url: URL,
          sourceApplication: String?,
          annotation: Any
      ) -> Bool {
          if(url.scheme == "sampleapp") {
              return true
          }
          return false
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
