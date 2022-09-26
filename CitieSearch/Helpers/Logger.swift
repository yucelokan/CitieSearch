//
//  Logger.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import Extensions

enum Logger {
    static func info(_ message: String) {
        guard AppConfiguration.type == .development else { return }
        print("[\(Date().fullFormatDate)] \(message)")
    }
}
