#import "EmmaReactNative.h"

#import <React/RCTLog.h>
#import <UserNotifications/UserNotifications.h>

#if __has_include(<emma-react-native-sdk/emma-react-native-sdk-Swift.h>)
#import <emma-react-native-sdk/emma-react-native-sdk-Swift.h>
#else
#import "emma-react-native-sdk-Swift.h"
#endif



@implementation EmmaReactNative

RCT_EXPORT_MODULE();

// MARK: AppDelegate
+(void) setPushNotificationsDelegate: (id<UNUserNotificationCenterDelegate>) notificationCenterDelegate {
    [[EmmaReactNativePush shared] setPushNotificationsDelegate:notificationCenterDelegate];
}

+(void) registerToken: (NSData *) deviceToken {
    [[EmmaReactNativePush shared] registerToken: deviceToken];
}

+(void) didReceiveNotificationResponse:(UNNotificationResponse *) response {
    [[EmmaReactNativePush shared] didReceiveNotificationWithUserInfo:response.notification.request.content.userInfo];
}

+(void) didReceiveNotificationResponse:(UNNotificationResponse *)response withActionIdentifier:(NSString*) actionIdentifier {
    [[EmmaReactNativePush shared] didReceiveNotificationWithUserInfo:response.notification.request.content.userInfo actionIdentifier:actionIdentifier];
}

+(void) willPresentNotificationWithUserInfo:(UNNotification *)notification {
    [[EmmaReactNativePush shared] willPresentNotificationWithUserInfo:notification.request.content.userInfo];
}

+(void) handleLink: (NSURL*) url {
    [EmmaReactNativeLinking handleLinkWithUrl:url];
    
}

//MARK: Start session and basics
RCT_EXPORT_METHOD(startSession:(NSDictionary*) configurationMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] startSession:configurationMap resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(trackUserLocation:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] trackUserLocation:resolve rejecter:reject];
}

//MARK: Events
RCT_EXPORT_METHOD(trackEvent:(NSDictionary*) requestMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] trackEvent:requestMap resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(loginUser:(NSDictionary*) loginMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] loginUser:loginMap resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(registerUser:(NSDictionary*) registerMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] registerUser:registerMap resolver:resolve rejecter:reject];
}

//MARK: Track user info
RCT_EXPORT_METHOD(trackUserExtraInfo:(NSDictionary*) infoMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] trackUserExtraInfo:infoMap resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(setCustomerId:(NSString*) customerId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] setCustomerId:customerId resolver:resolve rejecter:reject];
}

//MARK: In-App messaging
RCT_EXPORT_METHOD(inAppMessage:(NSDictionary*) messageMap resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] inAppMessage:messageMap resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(sendInAppImpression:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] sendInAppImpression:params resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(sendInAppClick:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] sendInAppClick:params resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(openNativeAd:(NSDictionary*) params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] openNativeAd:params resolver:resolve rejecter:reject];
}

//MARK: Push methods
RCT_EXPORT_METHOD(startPush:(NSDictionary*) pushParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] startPush:pushParams resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(sendPushToken: (NSString*) token resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] sendPushToken:token resolver:resolve rejecter:reject];
}

//MARK: GDPR
RCT_EXPORT_METHOD(isUserTrackingEnabled:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] isUserTrackingEnabled:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(enableUserTracking:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] enableUserTracking:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(disableUserTracking:(BOOL) deleteUser
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] disableUserTracking:deleteUser resolver:resolve rejecter:reject];
}

//MARK: Purchase
RCT_EXPORT_METHOD(startOrder:(NSDictionary*) orderParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] startOrder:orderParams resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(addProduct:(NSDictionary*) productParams resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] addProduct:productParams resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(trackOrder:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] trackOrder:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(cancelOrder:(NSString*)orderId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] cancelOrder:orderId resolver:resolve rejecter:reject];
}

//MARK: Track with IDFA
RCT_EXPORT_METHOD(requestTrackingWithIdfa:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [[EmmaReactNativeManager shared] requestTrackingWithIdfa:resolve rejecter:reject];
}

@end
