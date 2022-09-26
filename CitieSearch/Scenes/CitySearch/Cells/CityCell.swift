//
//  CityCell.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import UIKit

protocol CityItem {
    var title: String { get }
    var subtitle: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
}

class CityCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    func configureCell(_ item: CityItem) {
        titleLabel?.text = item.title
        subtitleLabel?.text = item.subtitle
    }
}
