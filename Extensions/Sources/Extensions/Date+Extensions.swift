//
//  Date+Extensions.swift
//  
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

public extension Date {
    
    /// Takes a date and converts it into String in given format
    func stringFromCustomDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var fullFormatDate: String {
        return stringFromCustomDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS")
    }
    
}
