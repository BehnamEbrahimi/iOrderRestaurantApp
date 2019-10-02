//
//  EnreesMenuTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/2/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

protocol EntreeProtocol {
    func setPickedEntrees(valueSent: [(dish: String, price: Float, amount: Int)])
}

class EnreesMenuTableViewController: UITableViewController  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entreeArray = [(dish: Dish, amount: Int)]()
    var alreadyPickedEntrees = [(dish: String, amount: Int)]()
    var delegate:EntreeProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEntrees()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEntrees()
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var pickedEntrees = [(dish: String, price: Float, amount: Int)]()
        
        for entree in entreeArray {
            if entree.amount > 0 {
                pickedEntrees.append((entree.dish.name!, entree.dish.unitPrice * Float(entree.amount), entree.amount ))
            }
        }
        
        delegate?.setPickedEntrees(valueSent: pickedEntrees)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return entreeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entree = entreeArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntreeMenuCell", for: indexPath) as! EntreeMenuCellTableViewCell
        
        cell.nameLable.text = entree.dish.name
        cell.priceLable.text = "\(entree.dish.unitPrice)"
        cell.descLable.text = entree.dish.desc
        cell.amountLable.text = "\(entree.amount)"
        cell.stepper.value = Double(entree.amount)
        
        if entree.dish.image != nil {
            cell.dishImageView.image =  UIImage(data: entree.dish.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.changeAmount = {
            self.entreeArray[indexPath.row].amount = Int(cell.stepper.value)
            cell.amountLable.text = "\(cell.stepper.value)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
           
    func loadEntrees(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            entreeArray = []
            
            var temp = [Dish]()
            temp = try context.fetch(request)
            
            for dish in temp {
                if dish.type == "entree" {
                    var matchAmount = 0
                    
                    for entree in alreadyPickedEntrees {
                        if entree.dish == dish.name {
                            matchAmount = entree.amount
                        }
                    }
                    
                    entreeArray.append((dish, matchAmount))
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
