//
//  OrderViewController.swift
//  iOrder
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
