//
//  UIApplication+Extensions.swift
//  
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import UIKit

public extension UIApplication {

    class func getViewController<T: UIViewController>(
        inScene named: String? = nil,
        rootViewController: Bool = true
    ) -> T {
        let controllerName = String(describing: T.self)
        let storyboardName = named ?? substringStoryboardName(withViewControllerName: controllerName)
        if rootViewController,
           let viewController = UIStoryboard(
               name: String(storyboardName), bundle: nil
           ).instantiateInitialViewController() as? T {
            return viewController
        } else if let viewController = UIStoryboard(
            name: String(storyboardName), bundle: nil
        ).instantiateViewController(withIdentifier: controllerName) as? T {
            return viewController
        } else {
            fatalError("InstantiateInitialViewController not found")
        }
    }

    private class func substringStoryboardName(withViewControllerName controllerName: String) -> String {
        let viewControllerName = controllerName
        if let range = viewControllerName.range(of: "ViewController") {
            return String(viewControllerName[..<range.lowerBound])
        } else {
            return controllerName
        }
    }
    
}
