package wao.flutter.application.project.vnpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.vnpay.authentication.VNP_AuthenticationActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** VnpayPlugin */
class VnpayPlugin: FlutterPlugin, MethodCallHandler, ActivityAware{
  private lateinit var channel : MethodChannel
  private var context: Context? = null
  private lateinit var activity: Activity
  private lateinit var pendingResult: MethodChannel.Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter.io/vnpay")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "vnpay") {
      pendingResult = result
      openVnPay(call.arguments() as Map<String,String>)
    }
  }

  private fun openVnPay(dict: Map<String,String>) {
    val intent = Intent(activity, VNP_AuthenticationActivity::class.java)
    intent.putExtra("url", dict["url"])
    intent.putExtra("tmn_code", dict["tmnCode"])
    intent.putExtra("scheme", dict["scheme"])
    intent.putExtra("is_sandbox", dict["isSandbox"] == "true")
    VNP_AuthenticationActivity.setSdkCompletedCallback { action ->
      //Người dùng nhấn back từ sdk để quay lại
      if(action == "AppBackAction"){
        pendingResult.success(-1)
      }
      //giao dịch thanh toán bị failed
      else if (action == "FaildBackAction"){
        pendingResult.success(1)
      }
      //thanh toán thành công trên webview
      else if (action == "SuccessBackAction"){
        pendingResult.success(1)
      }
      //Người dùng nhấn back từ trang thanh toán thành công khi thanh toán qua thẻ khi url có chứa: cancel.sdk.merchantbackapp
      else if (action == "WebBackAction"){
        pendingResult.success(1)
      }
      //Người dùng nhấn chọn thanh toán qua app thanh toán (Mobile Banking, Ví...)
      else if (action == "CallMobileBankingApp"){
        pendingResult.success(0)
      }
    }
    activity.startActivity(intent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
//    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
//    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }
}