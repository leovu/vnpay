package wao.flutter.application.project.vnpay

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log

class ResultActivity: Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val pm: PackageManager = applicationContext.packageManager
        val intent: Intent? = pm.getLaunchIntentForPackage(applicationContext.packageName)
        startActivity(intent)

        finish()
    }
}