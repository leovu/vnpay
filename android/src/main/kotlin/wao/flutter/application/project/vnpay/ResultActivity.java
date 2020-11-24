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
        }, 100);
    }

    public void navigateUp() {
        final Intent upIntent = NavUtils.getParentActivityIntent(this);
        if(upIntent != null) {
            try {
                Toast.makeText(this, "Vao try r ne", Toast.LENGTH_LONG).show();
                if (NavUtils.shouldUpRecreateTask(this, upIntent) || isTaskRoot()) {
                    Toast.makeText(this, "Vao if r ne", Toast.LENGTH_LONG).show();
                    TaskStackBuilder.create(this).addNextIntentWithParentStack(upIntent).startActivities();
                } else {
                    Toast.makeText(this, "Vao else r ne", Toast.LENGTH_LONG).show();
                    NavUtils.navigateUpTo(this, upIntent);
                }
            }
            catch(Exception e) {
                Toast.makeText(this, e.getMessage().toString(), Toast.LENGTH_LONG).show();
            }
        }
    }

}
