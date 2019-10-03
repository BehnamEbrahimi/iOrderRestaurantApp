//
//  OrderViewController.swift
//  iOrder
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, EntreeProtocol, MainProtocol, DesertProtocol {
    
    var pickedEntrees = [(dish: String, price: Float, amount: Int)]()
    var pickedMains = [(dish: String, price: Float, amount: Int)]()
    var pickedDeserts = [(dish: String, price: Float, amount: Int)]()
    
    func setPickedEntrees(valueSent: [(dish: String, price: Float, amount: Int)]) {
        self.pickedEntrees = valueSent
    }
    
    func setPickedMains(valueSent: [(dish: String, price: Float, amount: Int)]) {
        self.pickedMains = valueSent
    }
    
    func setPickedDeserts(valueSent: [(dish: String, price: Float, amount: Int)]) {
        self.pickedDeserts = valueSent
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
    
    
    @IBAction func mainBtnPressed(_ sender: UIButton) {
        var alreadyPickedMains = [(dish: String, amount: Int)]()
        
        for main in pickedMains {
            alreadyPickedMains.append((main.dish, main.amount ))
        }
        
        let mainsMenuTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainsMenuTableViewController") as! MainsMenuTableViewController
        
        mainsMenuTableViewController.delegate = self
        
        mainsMenuTableViewController.alreadyPickedMains = alreadyPickedMains
        
        self.navigationController?.pushViewController(mainsMenuTableViewController, animated: true)
    }
    
    @IBAction func desertBtnPressed(_ sender: UIButton) {
        var alreadyPickedDeserts = [(dish: String, amount: Int)]()
        
        for desert in pickedDeserts {
            alreadyPickedDeserts.append((desert.dish, desert.amount ))
        }
        
        let desertsMenuTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "DesertsMenuTableViewController") as! DesertsMenuTableViewController
        
        desertsMenuTableViewController.delegate = self
        
        desertsMenuTableViewController.alreadyPickedDeserts = alreadyPickedDeserts
        
        self.navigationController?.pushViewController(desertsMenuTableViewController, animated: true)
    }
    
    
    @IBAction func nextBtnPressed(_ sender: UIBarButtonItem) {
        var allOrders = [(dish: String, price: Float, amount: Int)]()
        
        allOrders = pickedEntrees + pickedMains + pickedDeserts
        
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
