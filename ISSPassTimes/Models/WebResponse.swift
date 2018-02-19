//
//  WebResponse.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/9/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

struct WebResponse: Codable {
    let message: String
    let request: Request
    let response: [Response]
}
