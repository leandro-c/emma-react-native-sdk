//
//  EmmaNativeAdDelegate.swift
//  emma-react-native-sdk
//
//  Created by Adrián Carrera on 18/03/2021.
//

import EMMA_iOS


@objcMembers
class EmmaNativeAdDelegate: NSObject, EMMAInAppMessageDelegate, EMMARequestDelegate {
    var resolve: (Any?) -> Void
    var reject: (String, String, NSError?) -> Void 
    
    init(resolve: @escaping (Any?) -> Void, reject: @escaping (String, String, NSError?) -> Void ) {
        self.resolve = resolve
        self.reject = reject
    }
    
    func onShown(_ campaign: EMMACampaign!) {
        // Not implemented
    }
    
    func onHide(_ campaign: EMMACampaign!) {
        // Not implemented
    }
    
    func onClose(_ campaign: EMMACampaign!) {
        // Not implemented
    }
    
    func onReceived(_ nativeAd: EMMANativeAd!) {
        let nativeAd = EmmaSerializer.nativeAdToDictionary(nativeAd)
        EMMA.removeInAppDelegate(delegate: self)
        resolve([nativeAd])
    }
    
    func onBatchNativeAdReceived(_ nativeAds: [EMMANativeAd]!) {
        var processedNativeAds: Array<[String: Any]> = []
        nativeAds.forEach { (nativeAd) in
            processedNativeAds.append(EmmaSerializer.nativeAdToDictionary(nativeAd))
        }
        EMMA.removeInAppDelegate(delegate: self)
        resolve(processedNativeAds)
    }
    
    func onStarted(_ id: String!) {
        // Not implemented
    }
    
    func onSuccess(_ id: String!, containsData data: Bool) {
        if (!data) {
            EMMA.removeInAppDelegate(delegate: self)
            resolve([])
        }
    }
    
    func onFailed(_ id: String!) {
        let error = NSError(domain: Error.requestFailed, code: 0, userInfo: nil)
        EMMA.removeInAppDelegate(delegate: self)
        reject(String(error.code), error.domain, error)
    }
}
