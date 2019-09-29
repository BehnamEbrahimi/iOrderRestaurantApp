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
        
        cell.textLabel?.text = entree.type
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //entreeArray[indexPath.row].done = !entreeArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    // MARK: - Model Manipulation Methods
    
    func loadEntrees(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            entreeArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
