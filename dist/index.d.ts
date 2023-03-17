import { AddProductParams, InAppMessageParams, LoginRegisterUserParams, NativeAd, OpenNativeAdParams, SendInAppParams, StartOrderParams, StartPushParams, StartSessionParams, TrackEventParams, TrackUserExtraInfoParams, PERMISSION_STATUS } from './types/index.types';
export * from './types/index.types';
export default class EmmaSdk {
    static startSession(startSessionParams: StartSessionParams): Promise<void>;
    static startPush(startPushParams: StartPushParams): void;
    static trackEvent(trackEventParams: TrackEventParams): void;
    static trackUserExtraInfo(trackUserExtraInfoParams: TrackUserExtraInfoParams): void;
    static trackUserLocation(): void;
    static loginUser(loginUserParams: LoginRegisterUserParams): void;
    static registerUser(registerUserParams: LoginRegisterUserParams): void;
    static startOrder(startOrderParams: StartOrderParams): void;
    static addProduct(addProductParams: AddProductParams): void;
    static trackOrder(): void;
    static cancelOrder(orderId: string): void;
    static inAppMessage(inAppMessageParams: InAppMessageParams): Promise<Array<NativeAd> | null>;
    static enableUserTracking(): void;
    static disableUserTracking(deleteUser: boolean): void;
    static isUserTrackingEnabled(): Promise<boolean>;
    static sendPushToken(token: string): void;
    static setCustomerId(customerId: string): void;
    static sendInAppImpression(sendInAppParams: SendInAppParams): void;
    static sendInAppClick(sendInAppParams: SendInAppParams): void;
    static openNativeAd(openNativeParams: OpenNativeAdParams): void;
    static requestTrackingWithIdfa(): void;
    static areNotificationsEnabled(): Promise<boolean>;
    static requestNotificationPermission(): Promise<PERMISSION_STATUS>;
}
