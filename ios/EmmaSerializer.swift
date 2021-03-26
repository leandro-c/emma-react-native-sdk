//
//  EmmaSerializer.swift
//  EmmaReactNative
//
//  Created by Adrián Carrera on 16/03/2021.
//  Copyright © 2021 EMMA. All rights reserved.
//

import Foundation
import EMMA_iOS

struct NativeAdShowOn {
    static let browser = "browser"
    static let inapp = "inapp"
    static let nativeAd = "nativeAd"
    static let adball = "adball"
    static let strip = "strip"
}

struct RCInAppType {
    static let startview = "startview"
    static let banner = "banner"
    static let nativeAd = "nativeAd"
    static let adball = "adball"
    static let strip = "strip"
}

class EmmaSerializer {
    class func mapToConfiguration(config: [String : Any?]) -> EMMAConfiguration? {
        let sessionKey = config["sessionKey"] as? String
        let apiUrl = config["apiUrl"] as? String
        let debugEnabled = config["isDebug"] as? Bool
        let queueTime = config["queueTime"] as? Int
        let customPowlinkDomains = config["customPowlinkDomains"] as? [String]
        let customShortPowlinkDomains = config["customShortPowlinkDomains"] as? [String]
        
        let configuration = EMMAConfiguration()
        
        guard Utils.isValidField(sessionKey) else {
            return nil
        }
        
        configuration.sessionKey = sessionKey
        
        if Utils.isValidField(apiUrl) {
            configuration.urlBase = apiUrl!
        }
        
        if Utils.isValidField(debugEnabled) {
            configuration.debugEnabled = debugEnabled!
        }
        
        if Utils.isValidField(queueTime) {
            configuration.queueTime = Int32(queueTime!)
        }
        
        if Utils.isValidField(customPowlinkDomains) {
            configuration.customPowlinkDomains = customPowlinkDomains
        }
        
        if Utils.isValidField(customShortPowlinkDomains) {
            configuration.shortPowlinkDomains = customShortPowlinkDomains
        }
        
        return configuration
    }
    
    class func inAppTypeFromString(inAppType: String?) -> InAppType? {
        switch inAppType {
            case RCInAppType.startview:
                return .Startview
            case RCInAppType.banner:
                return .Banner
            case RCInAppType.nativeAd:
                return .NativeAd
            case RCInAppType.adball:
                return .Adball
            case RCInAppType.strip:
                return .Strip
            default:
                return nil
        }
   }
    
    class func numericInAppTypeFromString(inAppType: String?) -> EMMACampaignType? {
        switch inAppType {
            case RCInAppType.nativeAd:
                return .campaignNativeAd
            default:
                return nil
        }
    }
    
    class func nativeAdToDictionary(_ nativeAd: EMMANativeAd) -> [String: Any] {
        return [
            "id": nativeAd.idPromo,
            "templateId": nativeAd.nativeAdTemplateId ?? "",
            "times": nativeAd.times,
            "tag": nativeAd.tag ?? NSNull(),
            "params": nativeAd.params ?? [:],
            "showOn": nativeAd.openInSafari ? NativeAdShowOn.browser : NativeAdShowOn.inapp,
            "fields": nativeAd.nativeAdContent as? [String: Any] ?? []
        ]
    }
}
