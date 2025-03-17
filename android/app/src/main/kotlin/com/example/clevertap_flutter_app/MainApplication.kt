package com.example.clevertap_flutter_app

import android.app.Application
import android.util.Log
import com.clevertap.android.pushtemplates.PushTemplateNotificationHandler
import com.clevertap.android.sdk.ActivityLifecycleCallback
import com.clevertap.android.sdk.CleverTapAPI
import com.clevertap.android.sdk.interfaces.NotificationHandler
import com.clevertap.clevertap_plugin.CleverTapApplication
import com.google.firebase.FirebaseApp

class MainApplication : CleverTapApplication() {
    override fun onCreate() {
        ActivityLifecycleCallback.register(this);
        CleverTapAPI.setDebugLevel(3);
        CleverTapAPI.setNotificationHandler(PushTemplateNotificationHandler())
        super.onCreate()
    }
}
