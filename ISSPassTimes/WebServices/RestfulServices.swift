//
//  RestfulServices.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/9/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation
import Alamofire


public enum ErrorCode: Int {
    case noNetwork = 1001
    case userAuthFailed = 1002
    case searverFailuer = 1003
    case badRequest = 1004
    case tokenInvalid = 1005
}

class RestfulServices{
    
    let rDomain = "com.valador.ramesh"
    let contentType = "Content-Type"
    let contentLength = "Content-Length"
    let applicationJson = "application/json"
    let accept = "Accept"
    
    // without creating multiple instaces using shared instance
    public static let shared = RestfulServices()
    
    public func getResponse(urlString: String, params: [String: Any]?, methodType method: String, completion connectionCompletion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        
        // checking internet connection
        if connectedToNetwork() {
            let url = URL(string: urlString)!
            Alamofire.request(url).responseData { (response) in
                if response.error != nil {
                    connectionCompletion(nil, self.handleError(statusCode: (response.error?._code)!))
                    /* for testing error codes
                    1) change error == nil,
                    2) comment above line connectionCompletion(nil, self.handleError(statusCode: (response.error?._code)!))
                    3) uncomment below line and pass different error codes */
                    
                    //self.handleError(statusCode: 412))
                } else {
                    connectionCompletion(response.data, response.error as NSError?)
                }
            }
        }else {
            let userDict = self.prepareUserDict("No Network availale", failureReason: "No Network")
            let error = NSError(domain: self.rDomain, code: ErrorCode.noNetwork.rawValue, userInfo: userDict)
            connectionCompletion(nil, error)
        }
    }
    
    // creating error meassege based on error code
    private func handleError(statusCode: Int) -> Error {
        var error: Error?
        switch statusCode {
        case 401:
            let userDict = self.prepareUserDict("User Authentication failed", failureReason: "User Authentication failed")
            error = NSError(domain: self.rDomain, code: ErrorCode.userAuthFailed.rawValue, userInfo: userDict)
            
        case 412:
            let userDict = self.prepareUserDict("Token expired", failureReason: "Token expired")
            error = NSError(domain: self.rDomain, code: ErrorCode.tokenInvalid.rawValue, userInfo: userDict)
            
        case 500:
            let userDict = self.prepareUserDict("Server failed", failureReason: "Server failed")
            error = NSError(domain: self.rDomain, code: ErrorCode.searverFailuer.rawValue, userInfo: userDict)
            
        default:
            let userDict = self.prepareUserDict("Bad Request", failureReason: "Bad Request")
            error = NSError(domain: self.rDomain, code: ErrorCode.badRequest.rawValue, userInfo: userDict)
        }
        
        return error!
    }
    
    
    // prepaing user error dictionary
    private func prepareUserDict(_ descriptionKey: String!, failureReason: String!) -> [String: Any] {
        
        return  [
            NSLocalizedDescriptionKey :  NSLocalizedString(descriptionKey, comment: failureReason) ,
            NSLocalizedFailureReasonErrorKey : NSLocalizedString(descriptionKey, comment: failureReason)
        ]
    }
}
