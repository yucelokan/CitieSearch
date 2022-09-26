//
//  AppDelegate.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var configuration: AppConfiguration = .init()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        
        configuration.configure()
        return true
    }
}
