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
    var entreeArray = [Dish]()
    
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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return entreeArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let entree = entreeArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntreeMenuCell", for: indexPath) as! EntreeMenuCellTableViewCell
        
        cell.nameLable.text = entree.name
        cell.priceLable.text = "\(entree.unitPrice)"
        cell.descLable.text = entree.desc
        cell.amountLable.text = "0"
        
        if entree.image != nil {
            cell.dishImageView.image =  UIImage(data: entree.image!)
        } else {
            cell.dishImageView.image = nil
        }
        
        cell.changeAmount = {
            print(cell.stepper.value)
        }
        
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
    
    @objc func back(sender: UIBarButtonItem) {
        print("hi")
        let msg = "kir"
        
        performSegue(withIdentifier: "addEntreesToOrder", sender: msg)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? OrderViewController, let msg = sender as? String {
        vc.pickedEntrees = msg
        }
    }


}
