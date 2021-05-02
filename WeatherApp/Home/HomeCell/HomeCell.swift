//
//  HomeCell.swift
//  WeatherApp
//
//  Created by Matthew on 28/4/21.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        weatherImage.layer.zPosition = 0
        darkLabel.layer.zPosition = 1
        tempLabel.layer.zPosition = 2
        cityNameLabel.layer.zPosition = 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
