package wao.flutter.application.project.vnpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import com.vnpay.authentication.VNP_AuthenticationActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.lang.Exception


/** VnpayPlugin */
class VnpayPlugin: FlutterPlugin, MethodCallHandler, ActivityAware , PluginRegistry.ActivityResultListener {
  private lateinit var channel : MethodChannel
  private var context: Context? = null
  private lateinit var activity: Activity
  private lateinit var pendinResult: MethodChannel.Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter.io/vnpay")
    channel.setMethodCallHandler(this)
    UtilProjectVnpayPlugin.binaryMessenger = flutterPluginBinding.binaryMessenger
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "vnpay") {
      pendinResult = result
      var dict:Map<String,String>? = call.arguments()
      openVnPay(dict!!)
    }
  }

  private fun openVnPay(dict: Map<String,String>) {
    if(context == null && pendinResult == null) {
      Handler().postDelayed({
        openVnPay(dict)
      }, 1500)
    }
    else {
      if (this::pendinResult.isInitialized) {
        if (pendinResult != null) {
          val intent = Intent(context,
                  StartActivity::class.java)
          intent.putExtra("url", dict["url"])
          intent.putExtra("scheme", dict["scheme"])
          intent.putExtra("tmn_code", dict["tmn_code"])
          activity.startActivityForResult(intent,101)
        }
      }
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, @Nullable data: Intent?): Boolean {
    try {
      if (this::pendinResult.isInitialized) {
        if (pendinResult != null) {
          if (requestCode == 102) {
            Toast.makeText(context,"Callback VNPay",Toast.LENGTH_LONG).show()
            if (resultCode == Activity.RESULT_CANCELED) { //press back
              pendinResult.success("AppBackAction")
            } else if (resultCode == 99) { // handle event backapp from url
              //todo something
              pendinResult.success("BackAction")
            } else {
              pendinResult.success("BackAction")
            }
          } else {
            pendinResult.success("BackAction")
          }
        }
      }
    }catch (e:Exception){
      
    }
    return true
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
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
//    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }
}
object UtilProjectVnpayPlugin {
  var binaryMessenger: BinaryMessenger? = null
}
