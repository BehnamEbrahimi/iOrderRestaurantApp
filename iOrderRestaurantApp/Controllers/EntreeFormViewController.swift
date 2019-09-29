//
//  EntreeFormViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/29/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class EntreeFormViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
     // MARK: - Add new entree
    
    @IBAction func addEntreeBtnPressed(_ sender: UIButton) {
        
        let newEntree = Dish(context: self.context)
        
        newEntree.name = self.nameField.text!
        newEntree.type = "entree"
        newEntree.unitPrice = (self.priceField.text as! NSString).floatValue
        
        self.saveEntrees()
    }
    
    // MARK: - Model Manipulation Methods
    func saveEntrees(){
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
}
