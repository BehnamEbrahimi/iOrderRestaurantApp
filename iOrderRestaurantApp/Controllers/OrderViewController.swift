//
//  OrderViewController.swift
//  iOrder
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, EntreeProtocol {
    
    var pickedEntrees = [(dish: String, price: Float, amount: Int)]()
    
    func setPickedEntrees(valueSent: [(dish: String, price: Float, amount: Int)]) {
        self.pickedEntrees = valueSent
    }
    
    @IBOutlet weak var tableNo: UIPickerView!
    @IBOutlet weak var staffName: UIPickerView!
    
    let tableNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    let staffNames = ["Ben", "Sarah", "Chloe"];
    var orderSummary = ["Table": "1", "Wait": "Ben", "Created at":"", "Total":""]
    
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
        if pickerView == staffName {
            orderSummary.updateValue(staffNames[row], forKey: "Wait")
        } else {
            orderSummary.updateValue(tableNumbers[row], forKey: "Table")
        }
    }
    
    @IBAction func entreeBtnPressed(_ sender: UIButton) {
        var alreadyPickedEntrees = [(dish: String, amount: Int)]()
        
        for entree in pickedEntrees {
            alreadyPickedEntrees.append((entree.dish, entree.amount ))
        }
        
        let enreesMenuTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnreesMenuTableViewController") as! EnreesMenuTableViewController
        
        enreesMenuTableViewController.delegate = self
        
        enreesMenuTableViewController.alreadyPickedEntrees = alreadyPickedEntrees
        
        self.navigationController?.pushViewController(enreesMenuTableViewController, animated: true)
    }
    
    @IBAction func nextBtnPressed(_ sender: UIBarButtonItem) {
        var allOrders = [(dish: String, price: Float, amount: Int)]()
        
        allOrders = pickedEntrees
        
        var sum = 0.0;
        for order in allOrders {
            sum = sum + Double(order.price)
        }
        
        orderSummary.updateValue("\(sum)", forKey: "Total")
        orderSummary.updateValue("\(Date())", forKey: "Created at")
        
        let bundled = [orderSummary, allOrders] as [Any]

        performSegue(withIdentifier: "confirmOrder", sender: bundled)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ConfirmOrderTableViewController, let bundled = sender {
            vc.orders = bundled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
