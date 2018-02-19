//
//  BaseRequest.swift
//  bykestation
//
//  Created by Luan Silva on 19/02/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit
import Alamofire

class BaseRequest {
    
    typealias onSuccess =  (_ success: Bool) -> Void
    typealias onArray = (_ resultArray: NSArray) -> Void
    typealias onJSON = (_ resultJson: [String: Any]) -> Void
    typealias onResponse = (DataResponse<Any>) -> Void
    
    static internal var session = Session.shared
    static private let responseGroup = DispatchGroup()
    static private var alamofireManager = Alamofire.SessionManager.default
    static internal let baseUrl: String = "http://app.bykestation.com.br/api/v1"
    static internal var endPoint: String = ""
    static internal var resultSuccess: Bool = false
    static internal var shouldShowError: Bool = false
    static internal var isGateway: Bool = false
    
    static internal func doDefaultRequestWith(requestType: HTTPMethod, parameters: [String: AnyObject]? = nil, completionOnSingleResult: @escaping onJSON, completionOnListResult: @escaping onArray, completionOnSuccess: @escaping onSuccess) {
        
        let alamofireManager = getAlamofireManager()
        var url = baseUrl + endPoint
        
        //gateway
        if isGateway {
            url = endPoint
        }
        isGateway = false
        
        
        if !NetworkUtils.isAvailable() {
            if shouldShowError {
                ServiceException.withStatusCode(NSURLErrorNotConnectedToInternet)
            }
            return completionOnSuccess(false)
        }
        
        ///Dispatch Group
        responseGroup.enter()
        let block = DispatchWorkItem(flags: .inheritQoS) {
            alamofireManager.request(url, method: requestType, parameters: parameters, encoding: JSONEncoding.default, headers: getHeader()).responseJSON { responseJSON in
                debugPrint("REQUEST ->", Date())
                debugPrint("URL&METHOD ->", url, requestType)
                if let statusCode = responseJSON.response?.statusCode {
                    debugPrint("REQUEST STATUS CODE -> ", statusCode)
                    if statusCode < 200 || statusCode > 299 {
                        if let json = responseJSON.result.value as? [String: Any] {
                            if let msg = json["msg"] as? String {
                                if shouldShowError {
                                    ServiceException.withType(.responseException(message: msg))
                                }
                                return completionOnSuccess(false)
                            }
                            if let msg = json["message"] as? String {
                                if shouldShowError {
                                    ServiceException.withType(.responseException(message: msg))
                                }
                                return completionOnSuccess(false)
                            }
                        }
                        if shouldShowError {
                            ServiceException.withStatusCode(statusCode)
                        }
                        return completionOnSuccess(false)
                    } else {
                        if statusCode == 204 { //sem retorno
                            resultSuccess = false
                        }else {
                            resultSuccess = true
                        }
                    }
                }
                
                switch responseJSON.result {
                case .failure(let error):
                    debugPrint("Error response failure:", error)
                default:
                    break
                }
                
                if let json = responseJSON.result.value as? [String: Any]  {
                    completionOnSingleResult(json)
                } else if let responseArray = responseJSON.result.value as? NSArray{
                    completionOnListResult(responseArray)
                } else if responseJSON.result.isFailure {
                    resultSuccess = false
                }
                responseGroup.leave()
            }
        }
        
        DispatchQueue.main.async(execute: block)
        responseGroup.notify(queue: DispatchQueue.main, execute: {
            completionOnSuccess(resultSuccess)
        })
    }
    
    static func doSearchRequest(requestType: HTTPMethod, parameters: [String: AnyObject], completionResult: @escaping onJSON) {
        
        let alamofireManager = getAlamofireManager()
        let url = baseUrl + endPoint
        
        alamofireManager.request(url, method: requestType, parameters: parameters, encoding: JSONEncoding.default, headers: getHeader()).responseJSON { responseJSON in
            
            if let statusCode = responseJSON.response?.statusCode {
                if statusCode < 200 || statusCode > 299 {
                    completionResult([:])
                }
            }
            
            if let json = responseJSON.result.value as? [String: Any]  {
                completionResult(json)
            } else {
                completionResult([:])
            }
        }
    }
    
    static func doCustomGetWith(url: String,  completionHandler: @escaping onResponse) {
        let alamofireManager = getAlamofireManager()
        alamofireManager.request(url).responseJSON { response in
            if let statusCode = response.response?.statusCode {
                if statusCode < 200 || statusCode > 299 {
                    if shouldShowError {
                        ServiceException.withType(.responseException(message: "Erro ao acessar o servidor. Por favor, tente mais tarde."))
                    }
                    return
                }
            }
            switch response.result {
            case .failure(let error):
                if shouldShowError {
                    ServiceException.withType(.responseException(message: "Erro ao acessar o servidor. Por favor, tente mais tarde."))
                }
                debugPrint("Error response failure:", error)
            default:
                break
            }
            completionHandler(response)
        }
    }
    
    //Private Helpers
    static private func getHeader() -> HTTPHeaders{
        if let accessToken = session.accessToken {
            let header = [
                "Content-Type": "application/json",
                "Authorization": "Token token=\(accessToken)" ]
            debugPrint("HEADER ->", header)
            return header
        } else {
            let header = ["Content-Type": "application/json"]
            debugPrint("HEADER ->", header)
            return header
        }
    }
    
    static private func getAlamofireManager() -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 39
        configuration.timeoutIntervalForRequest = 39
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        return alamofireManager
    }
}
