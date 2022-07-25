//
//  AppDelegate.swift
//  EmmaReactNativeExampleSwift
//
//  Created by Adrián Carrera on 29/03/2021.
//

import UIKit
import UserNotifications

// Imports for EMMA
import emma_react_native_sdk



#if FB_SONARKIT_ENABLED
struct FlipperBridge {
  static func start(application: UIApplication) {
    let flipperClient = FlipperClient.shared()
    let layoutDescriptorMapper = SKDescriptorMapper()
    flipperClient?.add(FlipperKitLayoutPlugin(rootNode: application, with: layoutDescriptorMapper))
    flipperClient?.add(FKUserDefaultsPlugin(suiteName: nil))
    flipperClient?.add(FlipperKitReactPlugin())
    flipperClient?.add(FlipperKitNetworkPlugin(networkAdapter: SKIOSNetworkAdapter()))
    flipperClient?.start()
  }
}
#endif

struct ReactNative {
  
  static func start(delegate: RCTBridgeDelegate, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> RCTRootView {
    
    #if FB_SONARKIT_ENABLED
      FlipperBridge.start(application: application)
    #endif
    
    let bridge = RCTBridge.init(delegate: delegate, launchOptions: launchOptions)
    return RCTRootView.init(bridge: bridge!, moduleName: "EmmaReactNativeExample", initialProperties: nil)
  }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate, UNUserNotificationCenterDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let rootView = ReactNative.start(delegate: self, launchOptions: launchOptions)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    
    // Pass push delegate to EMMA bridge
    if #available(iOS 10.0, *) {
      EmmaReactNativePush.shared.setPushNotificationsDelegate(self)
    }
    
    return true
  }

  func sourceURL(for bridge: RCTBridge) -> URL? {
    #if DEBUG
    return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
    #else
    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    #endif
  }
  
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    EmmaReactNativePush.shared.registerToken(deviceToken)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    NSLog("Error registering notifications " + error.localizedDescription);
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    EmmaReactNativePush.shared.didReceiveNotification(userInfo: userInfo)
    completionHandler(.noData)
  }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
    
      EmmaReactNativePush.shared.willPresentNotification(userInfo: notification.request.content.userInfo)
      completionHandler([.badge, .sound])
    }
  
  @available(iOS 10.0, *)
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
      EmmaReactNativePush.shared.didReceiveNotification(userInfo: response.notification.request.content.userInfo)
      completionHandler()
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    EmmaReactNativeLinking.handleLink(url: url)
    return RCTLinkingManager.application(UIApplication.shared, open: url, options: options)
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    
    if let webUrl = userActivity.webpageURL {
      EmmaReactNativeLinking.handleLink(url: webUrl)
    }

    return RCTLinkingManager.application(application, continue: userActivity, restorationHandler: restorationHandler)
  }

}

