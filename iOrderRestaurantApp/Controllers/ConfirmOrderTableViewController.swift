//
//  ConfirmOrderTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/29/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class ConfirmOrderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
}