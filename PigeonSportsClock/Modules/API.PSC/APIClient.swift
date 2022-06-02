//
//  APIClient.swift
//  PigeonSportsClock
//
//  Created by Anand on 26/04/22.
//

import Foundation
import Alamofire
import AlamofireMapper


class APIClient : NSObject {

    static let shared: APIClient = {
        let instance = APIClient()
        return instance
    }()

    private override init() {}

    public func performRegister(action: String, apptype: String,deivce_id: String, username: String, phone_no: String, password: String, completion: @escaping (Swift.Result<DataResponse<Register>?, Error>) -> ()){

        APIManager.shared.responseObjectsForEndPoint(router: APIRouter.doRegister(action: action, apptype: apptype, deivce_id: deivce_id, username: username, phone_no: phone_no, password: password)) { (Result) -> (Void) in
            DispatchQueue.main.async{

                completion(Result)
            }

        }
    }

    public func performLogin(apptype: String,user_name: String, password: String, completion: @escaping (Swift.Result<DataResponse<Login>?, Error>) -> ()) {
        APIManager.shared.responseObjectsForEndPoint(router: APIRouter.doLogin(apptype: apptype, user_name: user_name, password: password)){ (Result) -> (Void) in
            DispatchQueue.main.async{

                completion(Result)
            }
    }

}
    public func performGetClubList(completion: @escaping (Swift.Result<DataResponse<getClubList>?, Error>) -> ()){
        APIManager.shared.responseObjectsForEndPoint(router: APIRouter.doClubList) { (Result) -> (Void) in
            DispatchQueue.main.async{

                completion(Result)
            }
        }
    }

}
