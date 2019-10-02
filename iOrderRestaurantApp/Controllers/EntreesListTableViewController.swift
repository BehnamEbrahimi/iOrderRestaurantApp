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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEntrees()
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEntrees()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return entreeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entree = entreeArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntreeCell", for: indexPath) as! EntreeCellTableViewCell
        
        cell.nameLable.text = entree.name
        cell.priceLable.text = "\(entree.unitPrice)"
        cell.descLable.text = entree.desc
        
        if entree.image != nil {
            cell.dishImageView.image =  UIImage(data: entree.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.delAction = {
            self.context.delete(self.entreeArray[indexPath.row])
            
            self.entreeArray.remove(at: indexPath.row)
            
            do {
                try self.context.save()
            } catch {
                print("Error saving context \(error)")
            }
            
            tableView.reloadData()
            
        }
        
        cell.edtAction = {
            let dishToEdit = self.entreeArray[indexPath.row]
            
            self.performSegue(withIdentifier: "editEntreeSegue", sender: dishToEdit)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? EntreeFormViewController, let dishToEdit = sender as? Dish {
        vc.dishToEdit = dishToEdit
        }
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
                    entreeArray.append(dish)
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
