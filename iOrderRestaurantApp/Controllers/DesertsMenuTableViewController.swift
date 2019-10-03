//
//  DesertsMenuTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 10/3/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

protocol DesertProtocol {
    func setPickedDeserts(valueSent: [(dish: String, price: Float, amount: Int)])
}

class DesertsMenuTableViewController: UITableViewController  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var desertArray = [(dish: Dish, amount: Int)]()
    var alreadyPickedDeserts = [(dish: String, amount: Int)]()
    var delegate:DesertProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDeserts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDeserts()
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var pickedDeserts = [(dish: String, price: Float, amount: Int)]()
        
        for desert in desertArray {
            if desert.amount > 0 {
                pickedDeserts.append((desert.dish.name!, desert.dish.unitPrice * Float(desert.amount), desert.amount ))
            }
        }
        
        delegate?.setPickedDeserts(valueSent: pickedDeserts)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return desertArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let desert = desertArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesertMenuCell", for: indexPath) as! DesertMenuCellTableViewCell
        
        cell.nameLable.text = desert.dish.name
        cell.priceLable.text = "\(desert.dish.unitPrice)"
        cell.descLable.text = desert.dish.desc
        cell.amountLable.text = "\(desert.amount)"
        cell.stepper.value = Double(desert.amount)
        
        if desert.dish.image != nil {
            cell.dishImageView.image =  UIImage(data: desert.dish.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.changeAmount = {
            self.desertArray[indexPath.row].amount = Int(cell.stepper.value)
            cell.amountLable.text = "\(cell.stepper.value)"
        }
        
        return cell
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
                    var matchAmount = 0
                    
                    for desert in alreadyPickedDeserts {
                        if desert.dish == dish.name {
                            matchAmount = desert.amount
                        }
                    }
                    
                    desertArray.append((dish, matchAmount))
                }
            }
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
