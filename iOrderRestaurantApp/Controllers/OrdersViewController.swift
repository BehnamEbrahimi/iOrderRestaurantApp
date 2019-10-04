//
//  OrdersViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/28/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class OrdersViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var orderArray = [OrderSummary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadOrders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadOrders()
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return orderArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = orderArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersViewCell", for: indexPath) as! OrdersViewCell
        
        cell.dateLabel.text = order.date
        cell.waitLabel.text = order.wait
        cell.priceLabel.text = order.price
        cell.tableLabel.text = order.table
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadOrders(){
        let request : NSFetchRequest<OrderSummary> = OrderSummary.fetchRequest()
        do {
            orderArray = try context.fetch(request)
            orderArray = orderArray.reversed()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
