//
//  MainsListTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class MainsListTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var mainArray = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMains()
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mainArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let main = mainArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCellTableViewCell
        
        cell.nameLable.text = main.name
        cell.priceLable.text = "\(main.unitPrice)"
        cell.descLable.text = main.desc
        
        if main.image != nil {
            cell.dishImageView.image =  UIImage(data: main.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.delAction = {
            self.context.delete(self.mainArray[indexPath.row])
            
            self.mainArray.remove(at: indexPath.row)
            
            do {
                try self.context.save()
            } catch {
                print("Error saving context \(error)")
            }
            
            tableView.reloadData()
            
        }
        
        cell.edtAction = {
            let dishToEdit = self.mainArray[indexPath.row]
            
            self.performSegue(withIdentifier: "editMainSegue", sender: dishToEdit)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? MainFormViewController, let dishToEdit = sender as? Dish {
        vc.dishToEdit = dishToEdit
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadMains(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            mainArray = []
            
            var temp = [Dish]()
            temp = try context.fetch(request)
            
            for dish in temp {
                if dish.type == "main" {
                    mainArray.append(dish)
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
