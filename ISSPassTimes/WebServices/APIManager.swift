//
//  APIManager.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/10/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

// APIManager is to maintain network calls
class APIManager {
    
    
    static func fetchISSPassesInfo(latitude: Double, longitude: Double, onComplete: @escaping (_ received: WebResponse?, _ error: Error?) -> Void)  {

        let url = "http://api.open-notify.org/iss-pass.json?lat=\(latitude)&lon=\(longitude)"
        
        //Fetch the response from RestfulServices class
        RestfulServices.shared.getResponse(urlString: url, params: nil, methodType: "GET") { (receivedData, error) in
            if error == nil, let data = receivedData {
                do {
                    // using swift 4 feature Codable protocol
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(WebResponse.self, from: data)
                    onComplete(response, nil)
                } catch {
                    onComplete(nil, error)
                }
            } else {
                onComplete(nil, error)
            }
        }
    }
}
