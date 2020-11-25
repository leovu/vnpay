package wao.flutter.application.project.vnpay;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;

import androidx.annotation.Nullable;

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
            }
        }, 500);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        setResult(requestCode,data);
        navigateUp();
    }

    public void navigateUp() {
        try {
            final Intent upIntent = NavUtils.getParentActivityIntent(this);
            if(upIntent != null) {
                if (NavUtils.shouldUpRecreateTask(this, upIntent) || isTaskRoot()) {
                    TaskStackBuilder.create(this).addNextIntentWithParentStack(upIntent).startActivities();
                } else {
                    NavUtils.navigateUpTo(this, upIntent);
                }
            }
            else {
                finish();
            }
        }
        catch(Exception e) {
            finish();
        }
    }
}