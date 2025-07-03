//package com.example.clevertap_flutter_app
//
//import android.content.Intent
//import android.net.Uri
//import android.os.Build
//import com.clevertap.android.sdk.CleverTapAPI
//import com.google.firebase.messaging.Constants.MessageNotificationKeys.CHANNEL
//import io.flutter.embedding.android.FlutterFragmentActivity
//import io.flutter.plugin.common.MethodChannel
//
//
//class MainActivity: FlutterFragmentActivity(){
//
//     override fun onNewIntent(intent: Intent) {
//        super.onNewIntent(intent)
//
//        // On Android 12 and above, inform the notification click to get the pushClickedPayloadReceived callback on dart side.
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//            val cleverTapDefaultInstance = CleverTapAPI.getDefaultInstance(this)
//
//            cleverTapDefaultInstance?.pushNotificationClickedEvent(intent!!.extras)
//        }
//    }
//}



import android.content.Intent
import android.os.Build
import com.clevertap.android.sdk.CleverTapAPI
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "your_channel_name"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the MethodChannel with the same name as defined in Dart
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDataFromNative") {
                // Perform platform-specific operations and obtain the result
                val data = getDataFromNative()

                // Send the result back to Flutter
                result.success(data)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDataFromNative(): String {
        // Perform platform-specific operations to fetch the data
        return ""
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)

        // On Android 12 and above, inform the notification click to get the pushClickedPayloadReceived callback on dart side.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val cleverTapDefaultInstance = CleverTapAPI.getDefaultInstance(this)

            cleverTapDefaultInstance?.pushNotificationClickedEvent(intent!!.extras)
        }
    }
}






