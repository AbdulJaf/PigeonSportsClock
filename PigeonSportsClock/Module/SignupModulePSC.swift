//
//  SignupModulePSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 10/05/22.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Register: Codable {
    let apptype, username: String
    let status, activestatus, accountstatus: Int
    let userToken, userID, usertype: String
    let loftstatus, orgphoneNo: Int
    let phoneNo, origin, emailID, isCameraAllowed: String
    let expirydate, language, country: String
    let notifyStatus: Int
    let profileURL: String
    let readType: String
    let bluetoothID: JSONNull?
    let message: String

    enum CodingKeys: String, CodingKey {
        case apptype, username, status, activestatus, accountstatus, userToken
        case userID = "userId"
        case usertype, loftstatus
        case orgphoneNo = "Orgphone_no"
        case phoneNo = "phone_no"
        case origin
        case emailID = "email_id"
        case isCameraAllowed, expirydate, language, country
        case notifyStatus = "notify_status"
        case profileURL = "profile_url"
        case readType = "read_type"
        case bluetoothID = "bluetooth_id"
        case message
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
