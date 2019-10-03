//
//  MainCellTableViewCell.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class MainCellTableViewCell: UITableViewCell {
    var delAction: (() -> Void)? = nil
    var edtAction: (() -> Void)? = nil

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func delBtnPressed(_ sender: UIButton) {
        delAction?()
    }
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        edtAction?()
    }
    
}
