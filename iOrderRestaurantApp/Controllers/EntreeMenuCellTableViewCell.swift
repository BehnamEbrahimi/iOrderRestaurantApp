//
//  EntreeMenuCellTableViewCell.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/2/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class EntreeMenuCellTableViewCell: UITableViewCell {
    var changeAmount: (() -> Void)? = nil

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var amountLable: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        changeAmount?()
    }

}