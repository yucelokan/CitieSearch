//
//  UITableView+Extensions.swift
//  
//
//  Created by okan.yucel on 6.03.2022.
//

import UIKit

public extension UITableView {
    func reload(animation: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            guard animation else {
                self.reloadData()
                return
            }
            UIView.transition(
                with: self, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
                    self?.reloadData()
                }, completion: nil
            )
        }
    }
    
    func registerNib(_ type: UITableViewCell.Type, bundle: Bundle) {
        register(
            UINib(nibName: type.identifier, bundle: bundle),
            forCellReuseIdentifier: type.identifier
        )
    }

    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
}
