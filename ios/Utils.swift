//
//  Utils.swift
//  EmmaReactNative
//
//  Created by Adrián Carrera on 16/03/2021.
//  Copyright © 2021 EMMA. All rights reserved.
//

class Utils {
    
    class func isValidField(_ field: Any?) -> Bool {
        if !isNil(field) {
            if let str = field as? String, str.isEmpty {
               return false
            }
            return true
        }
        return false
    }

    class func isNil(_ value: Any?) -> Bool {
        guard let value = value else {
            return true
        }
        
        if  (value is NSNull) {
            return true
        }
        
        return false
    }
}
