//
//  EmmaReactNativeLinking.swift
//  emma-react-native-sdk
//
//  Created by Adrián Carrera on 30/03/2021.
//

import EMMA_iOS

@objcMembers
public class EmmaReactNativeLinking: NSObject {
    public class func handleLink(url: URL) {
        EMMA.handleLink(url: url)
    }
}


