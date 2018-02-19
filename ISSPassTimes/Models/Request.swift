//
//  Request.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/9/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

struct Request: Codable {
    let altitude: Int
    let datetime: Int
    let latitude: Double
    let longitude: Double
    let passes: Int
}
