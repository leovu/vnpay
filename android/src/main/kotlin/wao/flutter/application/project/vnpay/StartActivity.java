package wao.flutter.application.project.vnpay;

import android.app.Activity;
import android.app.TaskStackBuilder;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.Nullable;
import androidx.core.app.NavUtils;

import com.vnpay.authentication.VNP_AuthenticationActivity;

public class StartActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.startactivity);
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            public void run() {
                Intent intent = new Intent(StartActivity.this, VNP_AuthenticationActivity.class);
                intent.putExtra("url", getIntent().getStringExtra("url"));
                intent.putExtra("scheme", getIntent().getStringExtra("scheme"));
                intent.putExtra("tmn_code", getIntent().getStringExtra("tmn_code"));
                startActivityForResult(intent,102);
                finish();
            }
        }, 500);
    }
}