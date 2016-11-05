//
//  DetailViewTableViewCell.swift
//  goEuro
//
//  Created by Kamal Sampath Upasena on 11/5/16.
//  Copyright © 2016 self. All rights reserved.
//

import UIKit

class DetailViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProviderLogo: UIImageView!
    @IBOutlet weak var lblPriceBig: UILabel!
    @IBOutlet weak var lblPriceSmall: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDepathureTime: UILabel!
    @IBOutlet weak var lblArivalTime: UILabel!
    @IBOutlet weak var lblNumberOfStops: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
