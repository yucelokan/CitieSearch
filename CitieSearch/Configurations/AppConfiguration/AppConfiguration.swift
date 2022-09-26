//
//  AppConfiguration.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

protocol AppConfigurationLogic {
    func configure()
}

struct AppConfiguration {
    public init(configurable: AppConfigurationLogic = AppConfiguration.configuration) {
        self.configurable = configurable
    }

    private var configurable: AppConfigurationLogic

    func configure() {
        configurable.configure()
    }

    static var type: EnvironmentType {
        #if DEBUG
            return .development
        #elseif UAT
            return .staging
        #elseif PROD
            return .production
        #endif
    }
    
    enum EnvironmentType {
        case development
        case staging
        case production
    }
}

extension AppConfiguration {
    static var configuration: AppConfigurationLogic {
        switch type {
        case .development:
            return DEVConfiguration()
        case .staging:
            return UATConfiguration()
        case .production:
            return PRODConfiguration()
        }
    }
}
