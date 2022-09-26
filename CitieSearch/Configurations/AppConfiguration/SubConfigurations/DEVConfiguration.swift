//
//  DEVConfiguration.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

struct DEVConfiguration: AppConfigurationLogic {
    func configure() {
        Logger.info("dev_launched".localizeIt)
    }
}
