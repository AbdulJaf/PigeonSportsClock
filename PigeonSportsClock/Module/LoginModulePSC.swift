//
//  LoginModulePSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 10/05/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Login: Codable {
    let status: Int
    let message, userID, deviceid, version: String
    let userToken, apptype, latitude, longitude: String
    let usertype, username, model, phoneNo: String
    let readType, loftstatus: String
    let profileURL: String
    let androidID, country, language, notifyStatus: String
    let activestatus: Int
    let accountstatus, expirydate, isCameraAllowed: String
    let bluetoothID: BluetoothID

    enum CodingKeys: String, CodingKey {
        case status, message
        case userID = "userId"
        case deviceid, version, userToken, apptype, latitude, longitude, usertype, username, model
        case phoneNo = "phone_no"
        case readType = "read_type"
        case loftstatus
        case profileURL = "profile_url"
        case androidID = "android_id"
        case country, language
        case notifyStatus = "notify_status"
        case activestatus, accountstatus, expirydate, isCameraAllowed
        case bluetoothID = "bluetooth_id"
    }
}

// MARK: - BluetoothID
struct BluetoothID: Codable {
    let deviceName, deviceYear, macAddress: String
}

