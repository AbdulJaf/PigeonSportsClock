//
//  localizable.swift
//  PigeonSportsClock
//
//  Created by Anand on 18/03/22.
//

import Foundation

enum StringKey: String{

    case AlreadyRegistered = "AlreadyRegistered"
    case Signin = "Signin"
    case register = "register"
    case signup = "signup"

    //en-GB.lproj
    public var indentifier : String {

        if let path = Bundle.main.path(forResource: "en-GB", ofType: "lproj") {
               if let _ = Bundle(path: path) {
                 return NSLocalizedString(self.rawValue, comment: "")
               }
           }
        return self.rawValue
    }
}


func LSString(_ key : StringKey) -> String{
    return key.indentifier
}
