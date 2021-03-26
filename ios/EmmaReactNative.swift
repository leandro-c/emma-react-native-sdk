import EMMA_iOS

enum InAppAction {
    case click
    case impression
}

enum DefaultEvent {
    case login
    case register
}

@objc(EmmaReactNative)
open class EmmaReactNative: NSObject {
    static var sessionStarted = false
    
    /**
        This method avoids that SDK launching on main queue
     */
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }

    //MARK: Start session and basics
    @objc
    func startSession(_ configurationMap: [String : Any],
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
        
        guard let configuration = EmmaSerializer.mapToConfiguration(config: configurationMap) else {
            let error = NSError(domain: Error.invalidSessionKey, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.startSession(with: configuration)
        resolve(NSNull())
    }
    
    @objc
    func trackUserLocation(_ resolve: RCTPromiseResolveBlock,
                           rejecter reject: RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            EMMA.trackLocation()
        }
        resolve(nil)
    }
    
    //MARK: Track user info
    @objc
    func trackUserExtraInfo(_ infoMap: [String : Any],
                            resolver resolve: RCTPromiseResolveBlock,
                            rejecter reject: RCTPromiseRejectBlock) {
        
        guard let info = infoMap["userTags"] as? Dictionary<String, String>  else {
            let error = NSError(domain: Error.invalidUserInfoTags, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.trackExtraUserInfo(info: info)
        resolve(nil)
    }
    
    @objc
    func setCustomerId(_ customerId: String,
                       resolver resolve: RCTPromiseResolveBlock,
                       rejecter reject: RCTPromiseRejectBlock) {
        
        guard Utils.isValidField(customerId) else {
            let error = NSError(domain: Error.invalidToken, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.setCustomerId(customerId: customerId)
        resolve(nil)
    }
    
    //MARK: Events
    @objc
    func trackEvent(_ requestMap: [String : Any],
                    resolver resolve: RCTPromiseResolveBlock,
                    rejecter reject: RCTPromiseRejectBlock) {
        
        let token = requestMap["token"] as? String
        let attributes = requestMap["attributes"] as? Dictionary<String, Any>
        guard Utils.isValidField(token) else {
            let error = NSError(domain: Error.invalidToken, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        let request = EMMAEventRequest(token: token!)
        if let attributes = attributes {
            request.attributes = attributes
        }
        
        EMMA.trackEvent(request: request)
        resolve(nil)
    }
    
    func processLoginRegisten(_ loginMap: [String: Any],
                              type: DefaultEvent,
                              resolver resolve: RCTPromiseResolveBlock,
                              rejecter reject: RCTPromiseRejectBlock) {
        
        let userId = loginMap["userId"] as? String
        guard Utils.isValidField(userId) else {
            let error = NSError(domain: Error.invalidUserId, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        let email = loginMap["email"] as? String ?? ""
        
        if (type == .login) {
            EMMA.loginUser(userId: userId!, forMail: email, andExtras: nil)
        } else {
            EMMA.registerUser(userId: userId!, forMail: email, andExtras: nil)
        }
        
        resolve(nil)
    }
    
    @objc
    func loginUser(_ loginMap: [String: Any],
                   resolver resolve: RCTPromiseResolveBlock,
                   rejecter reject: RCTPromiseRejectBlock) {
        processLoginRegisten(loginMap, type: .login, resolver: resolve, rejecter: reject)
    }
    
    @objc
    func registerUser(_ registerMap: [String: Any],
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
        processLoginRegisten(registerMap, type: .register, resolver: resolve, rejecter: reject)
    }
    
    //MARK: Inapp messaging methods
    @objc
    func inAppMessage(_ messageMap: [String: Any],
                      resolver resolve: @escaping RCTPromiseResolveBlock,
                      rejecter reject: @escaping RCTPromiseRejectBlock) {
        
        let type = messageMap["type"] as? String
        guard let requestType = EmmaSerializer.inAppTypeFromString(inAppType: type) else {
            let error = NSError(domain: Error.unknowInappType, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        if (requestType == InAppType.NativeAd) {
            let templateId = messageMap["templateId"] as? String
            guard Utils.isValidField(templateId) else {
                let error = NSError(domain: Error.invalidTemplateId, code: 1, userInfo: nil)
                reject(String(error.code), error.domain, error)
                return
            }
            
            let batch = messageMap["batch"] as? Bool ?? false
            
            let nativeAdDelegate = EmmaNativeAdDelegate(resolve: resolve, reject: reject)
            
            let request = EMMANativeAdRequest()
            request.requestDelegate = nativeAdDelegate
            request.templateId = templateId
            request.isBatch = batch
            
            EMMA.inAppMessage(request: request, withDelegate: nativeAdDelegate)
        } else {
            let request = EMMAInAppRequest(type: requestType)
            EMMA.inAppMessage(request: request)
            resolve(NSNull())
        }
    }
    
    private func processInAppAction(_ params: [String : Any],
                            inappAction: InAppAction,
                            resolver resolve: RCTPromiseResolveBlock,
                            rejecter reject: RCTPromiseRejectBlock) {
        
        let type = params["type"] as? String
        guard let requestType = EmmaSerializer.numericInAppTypeFromString(inAppType: type) else {
            let error = NSError(domain: Error.unknowInappType, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        guard let campaignId = params["campaignId"] as? Int else {
            let error = NSError(domain: Error.invalidCampaignId, code: 1, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        if (inappAction == .impression) {
            EMMA.sendImpression(campaignType: requestType, withId: String(campaignId))
        } else {
            EMMA.sendClick(campaignType: requestType, withId: String(campaignId))
        }
        
        resolve(nil)
    }
    
    @objc
    func sendInAppImpression(_ params: [String : Any],
                             resolver resolve: RCTPromiseResolveBlock,
                             rejecter reject: RCTPromiseRejectBlock) {
        
        processInAppAction(params, inappAction: .impression, resolver: resolve, rejecter: reject)
    }
    
    @objc
    func sendInAppClick(_ params: [String : Any],
                        resolver resolve: RCTPromiseResolveBlock,
                        rejecter reject: RCTPromiseRejectBlock) {
        
        processInAppAction(params, inappAction: .click, resolver: resolve, rejecter: reject)
    }
    
    @objc
    func openNativeAd(_ params: [String : Any],
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
        
        guard let campaignId = params["campaignId"] as? Int else {
            let error = NSError(domain: Error.invalidCampaignId, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        DispatchQueue.main.async {
            EMMA.openNativeAd(campaignId: String(campaignId))
        }
        
        resolve(nil)
    }
    
    //MARK: Push methods
    //Push params only for Android
    @objc
    func startPush(_ pushParams: NSDictionary,
                   resolver resolve: RCTPromiseResolveBlock,
                   rejecter reject: RCTPromiseRejectBlock) {
        
        EmmaReactNativePush.shared.startPush()
        resolve(nil)
    }
    
    @objc
    func sendPushToken(_ token: String,
                       resolver resolve: RCTPromiseResolveBlock,
                       rejecter reject: RCTPromiseRejectBlock) {
        
        guard Utils.isValidField(token) else {
            let error = NSError(domain: Error.invalidPushToken, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.trackExtraUserInfo(info: ["token": token])
        resolve(nil)
    }
    
    //MARK: GDPR
    @objc
    func isUserTrackingEnabled(_ resolve: RCTPromiseResolveBlock,
                               rejecter reject: RCTPromiseRejectBlock) {
        resolve(EMMA.isUserTrackingEnabled())
    }
    
    @objc
    func enableUserTracking(_ resolve: RCTPromiseResolveBlock,
                            rejecter reject: RCTPromiseRejectBlock) {
        EMMA.enableUserTracking()
        resolve(nil)
    }
    
    @objc
    func disableUserTracking(_ deleteUser: Bool,
                            resolver resolve: RCTPromiseResolveBlock,
                            rejecter reject: RCTPromiseRejectBlock) {
        EMMA.disableUserTracking(deleteUser: deleteUser)
        resolve(nil)
    }

    @objc
    func startOrder(_ orderMap: [String : Any],
                    resolver resolve: RCTPromiseResolveBlock,
                    rejecter reject: RCTPromiseRejectBlock) {
        
        let orderId = orderMap["orderId"] as? String
        let totalPrice = orderMap["totalPrice"] as? Float
        let customerId = orderMap["customerId"] as? String
        let currencyCode = orderMap["currencyCode"] as? String
        let coupon = orderMap["coupon"] as? String
        let extras = orderMap["extras"] as? Dictionary<String, String>
        
        guard Utils.isValidField(orderId) else {
            let error = NSError(domain: Error.invalidOrderId, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        guard Utils.isValidField(totalPrice) else {
            let error = NSError(domain: Error.invalidTotalPrice, code: 1, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        guard Utils.isValidField(customerId) else {
            let error = NSError(domain: Error.invalidCustomerId, code: 2, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        if let currencyCode = currencyCode {
            EMMA.setCurrencyCode(currencyCode: currencyCode)
        }

        EMMA.startOrder(orderId: orderId!, andCustomer: customerId!, withTotalPrice: totalPrice!, withExtras: extras, assignCoupon: coupon)
        resolve(nil)
    }
    
    @objc
    func addProduct(_ productMap: [String : Any],
                    resolver resolve: RCTPromiseResolveBlock,
                    rejecter reject: RCTPromiseRejectBlock) {
        
        let productId = productMap["productId"] as? String
        let productName = productMap["productName"] as? String
        let quantity = productMap["quantity"] as? Float ?? 1
        let price = productMap["price"] as? Float ?? 0.0
        let extras = productMap["extras"] as? Dictionary<String, String>
        
        guard Utils.isValidField(productId) else {
            let error = NSError(domain: Error.invalidProductId, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.addProduct(productId: productId!, andName: productName!, withQty: quantity, andPrice: price, withExtras: extras)
        resolve(nil)
    }
    
    @objc
    func trackOrder(resolver resolve: RCTPromiseResolveBlock,
                    rejecter reject: RCTPromiseRejectBlock) {
        
        EMMA.trackOrder()
        resolve(nil)
    }
    
    @objc
    func cancelOrder(_ orderId: String,
                     resolver resolve: RCTPromiseResolveBlock,
                     rejecter reject: RCTPromiseRejectBlock) {
        
        guard Utils.isValidField(orderId) else {
            let error = NSError(domain: Error.invalidOrderId, code: 0, userInfo: nil)
            reject(String(error.code), error.domain, error)
            return
        }
        
        EMMA.cancelOrder(orderId: orderId)
        resolve(nil)
        
    }
    
    @objc
    func requestTrackingWithIdfa(_ resolve: RCTPromiseResolveBlock,
                                 rejecter reject: RCTPromiseRejectBlock) {
        if #available(iOS 14, *) {
            DispatchQueue.main.async {
                EMMA.requestTrackingWithIdfa()
            }
        }
        
        resolve(nil)
    }
}
