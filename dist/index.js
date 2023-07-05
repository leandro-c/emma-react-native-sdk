import { NativeModules, Platform } from 'react-native';
import { IN_APP_TYPE, PERMISSION_STATUS, } from './types/index.types';
export * from './types/index.types';
const { EmmaReactNative } = NativeModules;
export default class EmmaSdk {
    static startSession(startSessionParams) {
        return EmmaReactNative.startSession(startSessionParams);
    }
    static startPush(startPushParams) {
        EmmaReactNative.startPush(startPushParams);
    }
    static trackEvent(trackEventParams) {
        EmmaReactNative.trackEvent(trackEventParams);
    }
    static trackUserExtraInfo(trackUserExtraInfoParams) {
        EmmaReactNative.trackUserExtraInfo(trackUserExtraInfoParams);
    }
    static trackUserLocation() {
        EmmaReactNative.trackUserLocation();
    }
    static loginUser(loginUserParams) {
        EmmaReactNative.loginUser(loginUserParams);
    }
    static registerUser(registerUserParams) {
        EmmaReactNative.registerUser(registerUserParams);
    }
    static startOrder(startOrderParams) {
        EmmaReactNative.startOrder(startOrderParams);
    }
    static addProduct(addProductParams) {
        EmmaReactNative.addProduct(addProductParams);
    }
    static trackOrder() {
        EmmaReactNative.trackOrder();
    }
    static cancelOrder(orderId) {
        EmmaReactNative.cancelOrder(orderId);
    }
    static inAppMessage(inAppMessageParams) {
        if (inAppMessageParams.type === IN_APP_TYPE.BANNER && Platform.OS !== 'android') {
            return Promise.reject('Banner is unsupported on this device');
        }
        return EmmaReactNative.inAppMessage(inAppMessageParams);
    }
    static enableUserTracking() {
        EmmaReactNative.enableUserTracking();
    }
    static disableUserTracking(deleteUser) {
        EmmaReactNative.disableUserTracking(deleteUser);
    }
    static isUserTrackingEnabled() {
        return EmmaReactNative.isUserTrackingEnabled();
    }
    static sendPushToken(token) {
        EmmaReactNative.sendPushToken(token);
    }
    static setCustomerId(customerId) {
        EmmaReactNative.setCustomerId(customerId);
    }
    static sendInAppImpression(sendInAppParams) {
        EmmaReactNative.sendInAppImpression(sendInAppParams);
    }
    static sendInAppClick(sendInAppParams) {
        EmmaReactNative.sendInAppClick(sendInAppParams);
    }
    static openNativeAd(openNativeParams) {
        EmmaReactNative.openNativeAd(openNativeParams);
    }
    static requestTrackingWithIdfa() {
        if (Platform.OS === 'ios') {
            EmmaReactNative.requestTrackingWithIdfa();
        }
        else {
            console.error(`Unsupported platform: ${Platform.OS}`);
        }
    }
    static areNotificationsEnabled() {
        if (Platform.OS === 'android') {
            return EmmaReactNative.areNotificationsEnabled();
        }
        return Promise.resolve(false);
    }
    static requestNotificationPermission() {
        if (Platform.OS === 'android') {
            return EmmaReactNative.requestNotificationPermission();
        }
        return Promise.resolve(PERMISSION_STATUS.UNSUPPORTED);
    }
    static updateConversionValue(conversionValue) {
        if (Platform.OS === 'ios') {
            EmmaReactNative.updateConversionValue(conversionValue);
        }
    }
    static updateConversionValueSkad4(conversionModel) {
        if (Platform.OS === 'ios') {
            EmmaReactNative.updateConversionValueSkad4(conversionModel);
        }
    }
}
