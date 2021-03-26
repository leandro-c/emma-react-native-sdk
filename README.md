# EMMA React Native SDK

## Minimal Setup

Use EMMA SDK to register and gather information about installations, sessions, communications, and many other events.

```javascript
import React, { Component } from 'react';
import EmmaSdk from 'emma-react-native-sdk';

EmmaSdk.startSession(
  {
    sessionKey: 'EXAMPLE_EMMA_SESSION_KEY',
    isDebug: false, // Optional, default: false
    queueTime: 10, // Optional, default: 10
    customPowlinkDomains: ['example.com'], // Optional, default: []
    customShortPowlinkDomains: ['ex.co'], // Optional, default: []
    trackScreenEvents: true, // Optional, default: false
  },
  () => {
    console.log('Got it!');
  },
  (error) => {
    console.error('Oh, oh!', error);
  }
);
```

## Example

Read, build and try `EmmaReactNativeExample` application. It covers the main interactions with EMMA SDK.

For example, to launch the iOS version:

```
cd EmmaReactNativeExample
yarn
cd ios
pod install
cd ..
npm run ios
```

Refer to the [React Native documentation](https://reactnative.dev/) for further information.

## Relevant Notes

- Session has to be started before any other method is called.
- `Banner` communication format is only supported on Android devices.

## Documentation and further information

- [EMMA SDK Documentation & Support](https://developer.emma.io/)

## Use EMMA SDK everywhere

### Native

- [EMMA SDK for iOS](https://github.com/EMMADevelopment/eMMa-iOS-SDK)
- [EMMA SDK for Android](https://github.com/EMMADevelopment/EMMA-Android-SDK)

### Cross-platform

- [EMMA SDK for Cordova](https://github.com/EMMADevelopment/Cordova-Plugin-EMMA-SDK)
- [EMMA SDK for Ionic](https://github.com/EMMADevelopment/EMMAIonicExample)
- [EMMA SDK for Flutter](https://github.com/EMMADevelopment/emma_flutter_sdk)
- [EMMA SDK for Xamarin](https://github.com/EMMADevelopment/EMMA-Xamarin-SDK)
