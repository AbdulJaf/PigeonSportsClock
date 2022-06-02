//
//  APIManager.swift
//  PigeonSportsClock
//
//  Created by Anand on 26/04/22.
//

import Foundation
import Alamofire
import UIKit
import AlamofireMapper



enum MyCustomError: Error {
    case network( _ message: String?)
    case defaultError(_ msg : String)
    var localized_Description: String? {
        switch self {
        case .network(let message):
            return message
        case .defaultError(let message):
            return message
        }
    }
}
class APIManager : NSObject {

    /*** Singleton APIManager object to be used throughout the app ***/
    static let shared: APIManager = {
        let instance = APIManager()
        return instance
    }()

    private override init() {}


    public func responseObjectsForEndPoint<T : Decodable>(router : APIRouter, completion: @escaping ( Swift.Result<DataResponse<T>?, Error>) -> (Void)) {
        if !Reachability.isConnectedToNetwork(){
            completion(.failure(MyCustomError.network("No internet connection available.")))
            return
        }
        let queue = DispatchQueue(label: "com.response-queue", qos: .utility, attributes: [.concurrent])
        /*** Call API for the provided router ***/


         Alamofire.request(router).validate().responseObject(queue: queue, decoder: nil) { (response : DataResponse<T>) in
            DispatchQueue.main.async {
                /*** Return Error ***/
                if let data = response.data
                {
                    do{
                        //let responseValue = try JSONDecoder().decode(T.self, from: data)
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response---->\(jsonResponse)")
                    }catch let err{
                        print(err)
                    }
                }
                guard (response.data != nil) else {
                    print("API Error = \(response.error.debugDescription)")
                    completion(.failure(response.error ?? MyCustomError.defaultError("Server not response")))
                    return
                }

                completion(.success(response))
            }
        }
    }

    public func responseObjectsForEndPoint1<T : Decodable>(router : APIRouter, completion: @escaping ( Swift.Result<DataResponse<T>?, Error>) -> (Void)) {
        if !Reachability.isConnectedToNetwork(){
            completion(.failure(MyCustomError.network("No internet connection available.")))
            return
        }
        let queue = DispatchQueue(label: "com.response-queue", qos: .utility, attributes: [.concurrent])
        /*** Call API for the provided router ***/

        Alamofire.request(router).validate().responseObject(queue: queue, decoder: nil) { (response : DataResponse<T>) in
            DispatchQueue.main.async {
                /*** Return Error ***/
                if let data = response.data
                {
                    do{
                        let responseValue = try JSONDecoder().decode(T.self, from: data)
                        print("Response\(responseValue)")
                    }catch let err{
                        print(err)
                    }
                }
                guard response.result.isSuccess else {
                    completion(.failure(response.result.error ?? MyCustomError.defaultError("Server not response")))
                    return
                }

                completion(.success(response))
            }
        }
    }
    public func responseJSONForEndPoint(router : APIRouter, completion: @escaping (Any?, String?) -> ()) {

        if !Reachability.isConnectedToNetwork(){
            completion(nil, "No internet connection available.")
            return
        }

        let queue = DispatchQueue(label: "com.response-queue", qos: .utility, attributes: [.concurrent])
        /*** Call API for the provided router ***/
        Alamofire.request(router).validate().responseJSON(queue: queue) { (response) in
            print(response)
            /*** Return Error ***/
            guard response.result.isSuccess else {
              //  print("Error while fetching Response :: \(response.result.error?.localizedDescription ?? "Unknown Error")")
                completion(nil, response.result.error?.localizedDescription)
                return
            }

            /*** Return Error if SUCCESSSTATUS is not a bool ***/
            guard let value = response.result.value as? Dictionary<String,Any>, let _ = value[SUCCESSSTATUS] as? Bool else {
                let errorString = "Malformed data received from service"
                print(errorString)
                completion(nil, errorString)
                return
            }

            /*** Return Response ***/
            print(value)
            completion(value, nil)
        }
    }

    /**** Upload Multiform Picture ****/
    public func uploadPictureResponseForEndPoint<T : Decodable>(router : APIRouter, completion: @escaping (DataResponse<T>?, String?) -> Void) {

        if !Reachability.isConnectedToNetwork(){
            completion(nil, "No internet connection available.")
            return
        }

        guard let image = router.parameters["image"] as? UIImage, let imageData = image.jpegData(compressionQuality: 0.8),  let imageKeyName = router.parameters["imageKey"] as? String else {
            return
        }

        /*** Call API for the provided router ***/
        Alamofire.upload(multipartFormData: { (multiPartFormData) in

            if let parameters = router.parameters["params"] as? Dictionary<String, Any> {
                for (key, value) in parameters {
                    multiPartFormData.append(("\(value)").data(using: .utf8)!, withName: key)
                }
            }
            multiPartFormData.append(imageData, withName: imageKeyName,fileName: "file.jpg", mimeType: "image/jpg")

        }, with: router) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (response) in
                    completion(response, nil)
                })
            case .failure(let encodingError):
                completion(nil, encodingError.localizedDescription)
            }
        }
    }
}

