//
//  Error.swift
//  EmmaReactNative
//
//  Created by Adrián Carrera on 16/03/2021.
//  Copyright © 2021 EMMA. All rights reserved.
//

struct Error {
    static let invalidSessionKey = "Session key not found or empty"
    static let invalidToken = "Event token not found or empty"
    static let invalidUserInfoTags = "User info tag or invalid key/value, values must be string"
    static let invalidUserId = "User ID not found or empty"
    static let unknowInappType = "Unknown inapp type"
    static let invalidTemplateId = "Template ID not found or empty"
    static let requestFailed = "Request failed. Check if templateId exists or network is reachable"
    static let invalidCampaignId = "Invalid campaignId must be numeric"
    static let invalidPushToken = "Push token cannot be empty"
    static let invalidOrderId = "Order ID cannot be empty"
    static let invalidTotalPrice = "Order totalPrice is mandatory"
    static let invalidProductId = "Product ID cannot be empty"
    static let invalidCustomerId = "Customer ID cannot be empty"
}
