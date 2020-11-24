package wao.flutter.application.project.vnpay;

import android.app.Activity;
import android.app.TaskStackBuilder;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.Nullable;
import androidx.core.app.NavUtils;
import android.widget.Toast;


public class ResultActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.resultactivity);
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            public void run() {
                navigateUp();
            }
        }, 2000);
    }

    public void navigateUp() {
        final Intent upIntent = NavUtils.getParentActivityIntent(this);
        if(upIntent != null) {
            runOnUiThread(new Runnable(){
                public void run() {
                    try {
                        if (NavUtils.shouldUpRecreateTask(this, upIntent) || isTaskRoot()) {
                            TaskStackBuilder.create(this).addNextIntentWithParentStack(upIntent).startActivities();
                        } else {
                            NavUtils.navigateUpTo(this, upIntent);
                        }
                    }
                    catch(Exception e) {
                        Toast.makeText(this, e.getMessage().toString(), Toast.LENGTH_LONG).show();
                    }
                }
            });
        }
    }

}
