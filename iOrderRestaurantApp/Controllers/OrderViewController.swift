//
//  OrderViewController.swift
//  iOrder
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickedEntrees = [(dish: String, price: Float, amount: Int)]()
    
    @IBOutlet weak var tableNo: UIPickerView!
    @IBOutlet weak var staffName: UIPickerView!
    
    let tableNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    let staffNames = ["Ben", "Sarah", "Chloe"];
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == staffName {
            return staffNames[row]
        } else {
            return tableNumbers[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == staffName {
            return staffNames.count
        } else {
            return tableNumbers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    @IBAction func entreeBtnPressed(_ sender: UIButton) {
        var alreadyPickedEntrees = [(dish: String, amount: Int)]()
        
        for entree in pickedEntrees {
            alreadyPickedEntrees.append((entree.dish, entree.amount ))
        }
        
        performSegue(withIdentifier: "pickOrEditEntrees", sender: alreadyPickedEntrees)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? EnreesMenuTableViewController, let alreadyPickedEntrees = sender {
        vc.alreadyPickedEntrees = alreadyPickedEntrees as! [(dish: String, amount: Int)]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(pickedEntrees)
    }

}
