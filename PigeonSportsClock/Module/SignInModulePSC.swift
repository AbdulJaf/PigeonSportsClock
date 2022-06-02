//
//  SignInModulePSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 22/04/22.
//

import Foundation

// MARK: - Welcome
struct getClubList: Codable {
    let clublist: [Clublist]
    let clubCount, status: Int
    let message: String
    enum CodingKeys: String, CodingKey {
        case clublist
        case clubCount = "club_count"
        case status, message
    }
}

// MARK: - Clublist
struct Clublist: Codable {
    let ide, clubname, clubcode: String
}
