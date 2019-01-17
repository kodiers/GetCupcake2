//
//  OrderViewController.swift
//  GetCupcake
//
//  Created by Viktor Yamchinov on 10/01/2019.
//  Copyright © 2019 Viktor Yamchinov. All rights reserved.
//

import UIKit
import Intents

class OrderViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    var cake: Product!
    var toppings = Set<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // HACK TO WORK AROUND UIIMAGEVIEW IGNORING TEMPLATE IMAGE TINT COLOR
        let image = imageView.image
        imageView.image = nil
        imageView.image = image
        // END HACK
        
        let newOrder = Order(cake: cake, toppings: toppings)
        showDetails(newOrder)
        send(newOrder)
        donate(newOrder)
        
        title = "All set!"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showDetails(_ order: Order) {
        // update user interface with order's name and price
        details.text = order.name
        cost.text = "$\(order.price)"
    }
    
    func send(_ order: Order) {
        // convert order to JSON
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(order)
            // TODO: send order to somewhere
            print(data)
        } catch {
            print("Failed to create order")
        }
    }
    
    @objc func done() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func donate(_ order: Order) {
        
    }

}
