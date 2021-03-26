//
//  EmmaReactNativePush.swift
//  emma-react-native-sdk
//
//  Created by Adrián Carrera on 19/03/2021.
//

import Foundation
import UserNotifications
import EMMA_iOS

@objcMembers
public class EmmaReactNativePush: NSObject {
    public static let shared = EmmaReactNativePush()
    
    public weak var pushDelegate: UNUserNotificationCenterDelegate? {
        didSet {
            UNUserNotificationCenter.current().delegate = pushDelegate
        }
    }
    
    var pushStarted = false
    
    private override init() {
        super.init()
    }
    
    //MARK: Internal methods
    internal func startPush() {
        if #available(iOS 10, *) {
            if let delegate = pushDelegate {
                EMMA.setPushNotificationsDelegate(delegate: delegate)
            }
        }
        
        DispatchQueue.main.async {
            EMMA.startPushSystem()
        }
        
        pushStarted = true
    }
    
    //MARK: Public methods
    public func registerToken(_ token: Data) {
        if (pushStarted) {
            EMMA.registerToken(token)
        }
    }
    
    public func willPresentNotification(userInfo: [AnyHashable : Any]) {
        if (userInfo["eMMa"] != nil) {
            DispatchQueue.main.async {
                EMMA.handlePush(userInfo: userInfo)
            }
        }
    }
    
    public func didReceiveNotification(userInfo: [AnyHashable : Any]) {
        if (userInfo["eMMa"] != nil) {
            DispatchQueue.main.async {
                EMMA.handlePush(userInfo: userInfo)
            }
        }
    }
}
