//
//  UIViewController+BarButtonConfigurable.swift
//  
//
//  Created by okan.yucel on 6.03.2022.
//

import UIKit

public protocol BarButtonConfigurable: BarButtonItemConfiguration {}

/// Bar button position
public enum BarButtonItemPosition {
    case right, left
}

/// Custom bar button type
public enum BarButtonItemType {
    /// Pop view controller to back when selected.
    case pop(BarButtonItemPosition)
    /// Pop view controller to root when selected.
    case popToRoot(BarButtonItemPosition)
    /// Dismiss view controller selected.
    case dismiss(BarButtonItemPosition)
    /// custom button
    case custom(BarButtonItemPosition, image: String, action: Selector)
}

public protocol BarButtonItemConfiguration: AnyObject {
    func addBarButtonItem(ofType type: BarButtonItemType)
}

public extension BarButtonItemConfiguration where Self: UIViewController {
    func addBarButtonItem(ofType type: BarButtonItemType) {
        switch type {
        case let .pop(position):
            return newButton(
                imageName: "back",
                position: position,
                action: #selector(Self.popController)
            )
        case let .popToRoot(position):
            return newButton(
                imageName: "close",
                position: position,
                action: #selector(Self.popToRootController)
            )
        case let .dismiss(position):
            return newButton(
                imageName: "close",
                position: position,
                action: #selector(Self.dismissController)
            )
        case .custom(let position, let image, let action):
            return newButton(
                imageName: image,
                position: position,
                action: action
            )
        }
    }
    
    func newButton(imageName: String, position: BarButtonItemPosition, action: Selector?) {
        let button = UIBarButtonItem(
            image: UIImage(named: imageName),
            style: .plain,
            target: self,
            action: action
        )
        switch position {
        case .left: navigationItem.leftBarButtonItem = button
        case .right: navigationItem.rightBarButtonItem = button
        }
        if let image = button.image {
            button.tintColor = navigationController?.navigationBar.tintColor ?? .darkText
            button.image = image.withRenderingMode(.alwaysTemplate)
        }
    }
}

private extension UIViewController {
    @objc func popController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func popToRootController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func dismissController() {
        dismiss(animated: true)
    }
}
