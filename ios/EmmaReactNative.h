#import <React/RCTBridgeModule.h>
#import <UserNotifications/UserNotifications.h>

@interface EmmaReactNative : NSObject <RCTBridgeModule>
+(void) setPushNotificationsDelegate: (id<UNUserNotificationCenterDelegate>) notificationDelegate;
+(void) registerToken: (NSData *) deviceToken;
+(void) didReceiveNotificationResponse:(UNNotificationResponse *)response;
+(void) didReceiveNotificationResponse:(UNNotificationResponse *)response withActionIdentifier:(NSString*) actionIdentifier;
+(void) willPresentNotification:(UNNotification *)notification;
+(void) handleLink: (NSURL*) url;
@end
