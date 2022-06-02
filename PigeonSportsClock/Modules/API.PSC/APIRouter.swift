//
//  APIRouter.swift
//  PigeonSportsClock
//
//  Created by Anand on 26/04/22.
//

import Foundation
import Alamofire
import SwiftUI


public enum APIRouter : URLRequestConvertible {

    case doClubList
    case doRegister(action: String, apptype: String,deivce_id: String, username: String, phone_no: String, password: String)
    case doLogin(apptype: String,user_name: String, password: String)
    case doProfile(action: String)
    case doLoft(action: String, apptype: String, latitude: String, longitude: String, phone_no: String, files: String)
    case doDeviceRegister(action: String, reader_id:(deviceName: String, deviceYear: String, macAddress: String))
    case doBasketingregister(action: String, tag_id: String, reader_id: String)
    case doFancierScanning(action: String,event_id: String, tag_id: String,reader_id: String, latitude: String, longitude: String, time: String)
    case doProfileUpdate(action: String, user_id: String, profile_image: String, username: String)
    case doBirdTypeList(action: String, raceid: String, userid: String, apptype: String)
    case doAddPigeon(action: String, apptype: String, bird_type: String, ringno: String, gender: String, phone_no: String, raceId: String, user_id: String, color: String, usertype: String, scanReader: String, fancier_id: String)
    case doUpdateRaceLocation(action: String, racename: String, latitude: String, longitude: String, files: String)
    case doRaceList(action: String, apptype: String)
    case doCategoryList(New: (action: String, apptype: String, event_id: String, photo_created: String, phone_no: String), Old: (action: String, apptype: String, event_id: String, date: String, photo_created: String, start_time: String, end_time: String, race_distance: String, boarding_time: String, details_status: String, phone_no: String) )


    enum EnvironmentType{
        var BaseURL : String{
            return "https://pigeonsportsclock.com/pigeon/lespoton_new_version.php"

        }
    }
    var headers: Dictionary<String, String>? {

        switch self {
        case .doLogin,.doRegister,.doClubList,.doCategoryList,.doLogin,.doProfile,.doLoft,.doDeviceRegister,.doBasketingregister,.doFancierScanning,.doFancierScanning,.doProfileUpdate,.doBirdTypeList,.doAddPigeon,.doUpdateRaceLocation,.doRaceList:
            return [
                "Authorization":"Bearer "
            ]

        }
    }
    var method : HTTPMethod {
        switch self{
        case .doLogin,.doRegister,.doCategoryList,.doLogin,.doProfile,.doLoft,.doDeviceRegister,.doBasketingregister,.doFancierScanning,.doFancierScanning,.doProfileUpdate,.doBirdTypeList,.doAddPigeon,.doUpdateRaceLocation,.doRaceList:
            return .post

        case .doClubList:
            return .get

        }
    }
    var parameters: Dictionary<String, Any> {
        switch self {
        case .doLogin(let apptype,let user_name,let password):
            return ["apptype": apptype, "user_name": user_name, "password": password]
        case .doRegister(let action,let apptype,let deivce_id,let username,let phone_no,let password):
            return ["action": action, "apptype": apptype, "deivce_id": deivce_id, "username": username, "phone_no": phone_no, "password": password]

        case .doClubList:
            return [:]
        case .doProfile( let action):
            return ["action": action]
        case .doLoft( let action,  let apptype, let latitude, let longitude, let phone_no,let files):
            return ["action": action, "apptype": apptype, "latitude": latitude, "longitude": longitude, "phone_no": phone_no, "files": files]
        case .doDeviceRegister( let action, let reader_id):
            return [ "action": action,"reader_id": reader_id ]
        case .doBasketingregister(let action,let tag_id,let reader_id):
            return ["action": action, "tag_id": tag_id, "reader_id": reader_id]
        case .doFancierScanning( let action,  let event_id, let tag_id, let reader_id, let latitude,  let longitude, let time):
            return [ "action":  action, "event_id": event_id, "tag_id": tag_id, "reader_id":  reader_id, "latitude": latitude, "longitude": longitude, "time":  time]
        case .doProfileUpdate(let action,  let user_id, let profile_image, let username):
            return [ "action": action, "user_id":user_id, "profile_image":  profile_image, "username": username]
        case .doBirdTypeList(let action, let raceid, let userid, let apptype):
            return ["action": action, "raceid": raceid, "userid":  userid, "apptype": apptype]
        case .doAddPigeon(let action, let apptype,let bird_type,let ringno, let gender,let phone_no, let raceId, let user_id,  let color, let usertype,  let scanReader, let fancier_id):
            return ["action": action, "apptype": apptype, "bird_type":  bird_type, "ringno":  ringno, "gender":  gender, "phone_no":  phone_no, "raceId":  raceId, "user_id": user_id, "color":  color, "usertype":usertype, "scanReader": scanReader, "fancier_id":  fancier_id]
        case .doUpdateRaceLocation(let action, let racename,let latitude,let longitude, let files):
            return ["action":action, "racename":  racename, "latitude": latitude, "longitude":longitude, "files":  files]
        case .doRaceList(let action, let apptype):
            return ["action":  action, "apptype": apptype]
        case .doCategoryList( let New, let Old):
            return ["New": New,"Old":  Old]
        }
    }
    /*** URL encoding for each router ***/
    var encoding: ParameterEncoding{
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    public func asURLRequest() throws -> URLRequest {
        let url = try currentEnvironment.BaseURL.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers

        print("URL--> \(request.url?.absoluteString ?? "")")
        print("Params-->\(parameters)")
        print("Header---->\(headers)")
        switch self {
        case
                .doLogin,.doRegister,.doCategoryList,.doLogin,.doProfile,.doLoft,.doDeviceRegister,.doBasketingregister,.doFancierScanning,.doFancierScanning,.doProfileUpdate,.doBirdTypeList,.doAddPigeon,.doUpdateRaceLocation,.doRaceList,.doClubList:

            return try encoding.encode(request, with: parameters)
        }
    }


}
