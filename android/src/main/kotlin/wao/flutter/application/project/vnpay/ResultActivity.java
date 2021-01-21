package wao.flutter.application.project.vnpay;

import android.app.Activity;
import android.app.TaskStackBuilder;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.Nullable;
import androidx.core.app.NavUtils;
import android.widget.Toast;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;


public class ResultActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.resultactivity);
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            public void run() {
                finish();
                MethodChannel channel = new MethodChannel(UtilProjectVnpayPlugin.INSTANCE.getBinaryMessenger(),"flutter.io/vnpay_success_callback");
                channel.invokeMethod("vnpay_success_callback",null);
            }
        }, 500);
    }

}
