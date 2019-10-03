//
//  MainsMenuTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

protocol MainProtocol {
    func setPickedMains(valueSent: [(dish: String, price: Float, amount: Int)])
}

class MainsMenuTableViewController: UITableViewController  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var mainArray = [(dish: Dish, amount: Int)]()
    var alreadyPickedMains = [(dish: String, amount: Int)]()
    var delegate:MainProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMains()
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var pickedMains = [(dish: String, price: Float, amount: Int)]()
        
        for main in mainArray {
            if main.amount > 0 {
                pickedMains.append((main.dish.name!, main.dish.unitPrice * Float(main.amount), main.amount ))
            }
        }
        
        delegate?.setPickedMains(valueSent: pickedMains)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mainArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let main = mainArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCellTableViewCell
        
        cell.nameLable.text = main.dish.name
        cell.priceLable.text = "\(main.dish.unitPrice)"
        cell.descLable.text = main.dish.desc
        cell.amountLable.text = "\(main.amount)"
        cell.stepper.value = Double(main.amount)
        
        if main.dish.image != nil {
            cell.dishImageView.image =  UIImage(data: main.dish.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.changeAmount = {
            self.mainArray[indexPath.row].amount = Int(cell.stepper.value)
            cell.amountLable.text = "\(cell.stepper.value)"
        }
        
        return cell
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
                    var matchAmount = 0
                    
                    for main in alreadyPickedMains {
                        if main.dish == dish.name {
                            matchAmount = main.amount
                        }
                    }
                    
                    mainArray.append((dish, matchAmount))
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
