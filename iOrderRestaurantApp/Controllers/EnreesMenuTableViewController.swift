//
//  EnreesMenuTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/2/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class EnreesMenuTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entreeArray = [(dish: Dish, amount: Int)]()
    var alreadyPickedEntrees = [(dish: String, amount: Int)]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEntrees()
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "<Taking Order", style: UIBarButtonItem.Style.plain, target: self, action: #selector(EnreesMenuTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        loadEntrees()
        print(alreadyPickedEntrees)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return entreeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var entree = entreeArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntreeMenuCell", for: indexPath) as! EntreeMenuCellTableViewCell
        
        cell.nameLable.text = entree.dish.name
        cell.priceLable.text = "\(entree.dish.unitPrice)"
        cell.descLable.text = entree.dish.desc
        cell.amountLable.text = "\(entree.amount)"
        
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
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    // MARK: - Model Manipulation Methods
    
    func loadEntrees(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            entreeArray = []
            
            var temp = [Dish]()
            temp = try context.fetch(request)
            
            for dish in temp {
                if dish.type == "entree" {
                    entreeArray.append((dish, 0))
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
        var pickedEntrees = [(dish: String, price: Float, amount: Int)]()
        
        for entree in entreeArray {
            if entree.amount > 0 {
                pickedEntrees.append((entree.dish.name!, entree.dish.unitPrice * Float(entree.amount), entree.amount ))
            }
        }
        
        performSegue(withIdentifier: "addEntreesToOrder", sender: pickedEntrees)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? OrderViewController, let pickedEntrees = sender {
        vc.pickedEntrees = pickedEntrees as! [(dish: String, price: Float, amount: Int)]
        }
    }


}
