#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>

@interface RCT_EXTERN_MODULE(EmmaReactNative, NSObject)

//MARK: Start session and basics
RCT_EXTERN_METHOD(startSession:(NSDictionary*) configurationMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(trackUserLocation:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

//MARK: Events
RCT_EXTERN_METHOD(trackEvent:(NSDictionary*) requestMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(loginUser:(NSDictionary*) loginMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(registerUser:(NSDictionary*) registerMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

//MARK: Track user info
RCT_EXTERN_METHOD(trackUserExtraInfo:(NSDictionary*) infoMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(setCustomerId:(NSString*) customerId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

//MARK: In-App messaging
RCT_EXTERN_METHOD(inAppMessage:(NSDictionary*) messageMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(sendInAppImpression:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(sendInAppClick:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(openNativeAd:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)


//MARK: Push methods
RCT_EXTERN_METHOD(startPush:(NSDictionary*) pushParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(sendPushToken: (NSString*) token resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

//MARK: GDPR
RCT_EXTERN_METHOD(isUserTrackingEnabled:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(enableUserTracking:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(disableUserTracking:(BOOL) deleteUser
                  resolver resolve: RCTPromiseResolveBlock
                  rejecter reject: RCTPromiseRejectBlock)

//MARK: Purchase
RCT_EXTERN_METHOD(startOrder:(NSDictionary*) orderParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(addProduct:(NSDictionary*) productParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(trackOrder:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(cancelOrder:(NSString*)orderId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

//MARK: Track with IDFA
RCT_EXTERN_METHOD(requestTrackingWithIdfa:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end
