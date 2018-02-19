//
//  UtilityClass.swift
//  ISSPassTimes
//
//  Created by Ramesh_Venteddu on 2/10/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation
class UtilityClass {
    
    static func getTimeStamp(for timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter.string(from: date)
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        return "\( (seconds % 3600) / 60)m : \((seconds % 3600) % 60)s"
    }
}
