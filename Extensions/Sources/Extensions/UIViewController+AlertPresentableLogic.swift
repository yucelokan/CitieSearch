//
//  UIViewController+Extensions.swift
//  
//
//  Created by okan.yucel on 8.03.2022.
//

import UIKit

public protocol AlertPresentableLogic { }

public extension AlertPresentableLogic where Self: UIViewController {
    
    func presentAlert(_ title: String, message: String, actionTitle: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: actionTitle, style: .default, handler: { _ in
                action?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
