//
//  OrdersViewCell.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class OrdersViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var waitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
