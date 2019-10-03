//
//  DesertsListTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class DesertsListTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var desertArray = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDeserts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDeserts()
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return desertArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let desert = desertArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesertCell", for: indexPath) as! DesertCellTableViewCell
        
        cell.nameLable.text = desert.name
        cell.priceLable.text = "\(desert.unitPrice)"
        cell.descLable.text = desert.desc
        
        if desert.image != nil {
            cell.dishImageView.image =  UIImage(data: desert.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.delAction = {
            self.context.delete(self.desertArray[indexPath.row])
            
            self.desertArray.remove(at: indexPath.row)
            
            do {
                try self.context.save()
            } catch {
                print("Error saving context \(error)")
            }
            
            tableView.reloadData()
            
        }
        
        cell.edtAction = {
            let dishToEdit = self.desertArray[indexPath.row]
            
            self.performSegue(withIdentifier: "editDesertSegue", sender: dishToEdit)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? DesertFormViewController, let dishToEdit = sender as? Dish {
        vc.dishToEdit = dishToEdit
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadDeserts(){
        let request : NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            desertArray = []
            
            var temp = [Dish]()
            temp = try context.fetch(request)
            
            for dish in temp {
                if dish.type == "desert" {
                    desertArray.append(dish)
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
