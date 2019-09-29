//
//  EntreesListTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class EntreesListTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entreeArray = [Dish]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEntrees()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return entreeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntreeCell", for: indexPath)
        
        let entree = entreeArray[indexPath.row]
        
        cell.textLabel?.text = entree.name
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //entreeArray[indexPath.row].done = !entreeArray[indexPath.row].done
        
        saveEntrees()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Add new entree
    @IBAction func addEntreeButtonPressed(_ sender: UIBarButtonItem) {
        
        var nameField = UITextField()
        var priceField = UITextField()
        
        let alert = UIAlertController(title: "Add New Entree", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Entree", style: .default) { (action) in
            let newEntree = Dish(context: self.context)
            newEntree.name = nameField.text!
            newEntree.type = "entree"
            newEntree.unitPrice = (priceField.text as! NSString).floatValue
            
            self.entreeArray.append(newEntree)
            
            self.saveEntrees()
        }
        
        alert.addTextField { (alertNameField) in
            alertNameField.placeholder = "Name"
            nameField = alertNameField
        }
        
        alert.addTextField { (alertPriceField) in
            alertPriceField.placeholder = "Price"
            priceField = alertPriceField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Methods
    func saveEntrees(){
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadEntrees(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            entreeArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
