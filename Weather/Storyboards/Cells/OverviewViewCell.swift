//
//  OverviewViewCell.swift
//  Weather
//
//  Created by Vladimir Nitochkin on 24/07/2019.
//  Copyright © 2019 Vladimir Nitochkin. All rights reserved.
//

import UIKit

class OverviewViewCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
