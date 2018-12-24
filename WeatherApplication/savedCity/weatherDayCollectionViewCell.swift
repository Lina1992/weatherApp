//
//  weatherDayCollectionViewCell.swift
//  WeatherApplication
//
//  Created by pazl992 on 23.12.2018.
//  Copyright © 2018 pazl992. All rights reserved.
//

import UIKit
class weatherDayCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with data: NSDictionary) {
        
    }
}
