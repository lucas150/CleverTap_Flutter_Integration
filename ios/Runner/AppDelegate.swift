import Flutter
import UIKit
import CleverTapSDK
import clevertap_plugin

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    CleverTap.autoIntegrate() // integrate CleverTap SDK using the autoIntegrate option
    CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
      registerForPush()
    CleverTapPlugin.sharedInstance()?.applicationDidLaunch(options: launchOptions)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func registerForPush() {
        // Register for Push notifications
        UNUserNotificationCenter.current().delegate = self
        // request Permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }
}
