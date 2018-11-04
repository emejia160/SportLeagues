//
//  BaseRepository.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case Success(T)
    case Failure(NSError)
}

class BaseRepository {
    
    static func callService<T>(url: String, method: HTTPMethod, parameters: [String:Any], encoding: ParameterEncoding, headers: HTTPHeaders, responseHandler: @escaping ((_ result: Result<T>) -> Void)) where T: Decodable {
        var header = headers
        header["accept"] = "application/json"
        header["X-Api-Key"] = "1"
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        print("REQUEST URL: \(url)")
        manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    do {
                        let data: T = try BaseRepository.parseData(retrievedData: response.result.value)
                        responseHandler(Result.Success(data))
                    } catch {
                        
                        let error = NSError(domain: "Parsing error.",
                                            code: response.response?.statusCode ?? 0,
                                            userInfo: ["message": NSLocalizedString("message.general.error", comment: "")])
                        
                        responseHandler(Result.Failure(error))
                    }
                    
                case .failure(let responseError):
                    var statusCode = 0
                    let errorMessage = NSLocalizedString("message.general.error", comment: "")
                    
                    if let response = response.response {
                        statusCode = response.statusCode
                    }
                    
                    let error = NSError(domain: responseError.localizedDescription,
                                        code: statusCode,
                                        userInfo: ["message": errorMessage])
                    
                    responseHandler(Result.Failure(error))
                }
        }
    }
    
    static func callService(url: String, method: HTTPMethod, parameters: [String:Any], encoding: ParameterEncoding, headers: HTTPHeaders, responseHandler: @escaping ((_ result: Any?, _ error: NSError?) -> Void)) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        
        print("REQUEST URL: \(url)")
        manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    guard let response = response.result.value as? [String : AnyObject] else {
                        responseHandler(nil,nil)
                        return
                    }
                    
                    responseHandler(response,nil)
                    
                case .failure(let responseError):
                    var statusCode = 0
                    if let response = response.response {
                        statusCode = response.statusCode
                    }
                    
                    let error = NSError(domain: responseError.localizedDescription,
                                        code: statusCode,
                                        userInfo: ["message": "Se ha presentado un error."])
                    responseHandler(nil, error)
                }
        }
    }
    
    static func parseData<T: Decodable>(retrievedData: Any?) throws -> T {
        if let json = retrievedData as? [String : AnyObject] {
            if let responseData = json["teams"] as? [String:Any] {
                if let data: T = T.toModel(data: responseData) {
                    return data
                }
            }
            else if let responseData = json["teams"] as? [[String:Any]] {
                if let data: T = T.toModel(data: responseData) {
                    return data
                }
            }
            else {
                if let data: T = T.toModel(data: json) {
                    return data
                }
            }
        }
        
        throw DataError.ParsingError()
    }
}

