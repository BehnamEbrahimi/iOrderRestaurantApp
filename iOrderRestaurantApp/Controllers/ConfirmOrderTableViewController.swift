//
//  ConfirmOrderTableViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/29/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ConfirmOrderTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var orders:Any!
    var ordersItem = [(dish: String, price: Float, amount: Int)]()
    var orderSummary = ["Table": "", "Wait": "", "Created at":"", "Total":""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersItem = []
        let temp = (orders as! NSArray)[1] as! NSArray
        for order in temp {
            ordersItem.append(order as! (dish: String, price: Float, amount: Int))
        }
        
        orderSummary = (orders as! NSArray)[0] as! [String : String]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ordersItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let orderItem = ordersItem[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmOrderCell", for: indexPath) as! ConfirmOrderTableViewCell
        
        cell.dishLabel.text = orderItem.dish
        cell.priceLabel.text = "\(orderItem.price)"
        cell.amountLabel.text = "\(orderItem.amount)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        let newOrder = OrderSummary(context: context)
        
        newOrder.table = orderSummary["Table"]
        newOrder.wait = orderSummary["Wait"]
        newOrder.date = orderSummary["Created at"]
        newOrder.price = orderSummary["Total"]
        
        saveOrder()
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "\(ordersItem)"
            controller.recipients = ["0479182363"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func saveOrder(){
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
