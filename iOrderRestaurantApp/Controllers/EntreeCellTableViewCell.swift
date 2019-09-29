//
//  EntreeCellTableViewCell.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/29/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class EntreeCellTableViewCell: UITableViewCell {
    var delAction: (() -> Void)? = nil

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func delBtnPressed(_ sender: UIButton) {
        delAction?()
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
    }
    
}
